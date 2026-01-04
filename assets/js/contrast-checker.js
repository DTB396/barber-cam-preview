/**
 * Contrast Checker
 * Automatically checks and fixes contrast issues for accessibility
 * Applied to elements with data-contrast="auto" attribute
 */
(() => {
  const MIN_RATIO = 4.5; // WCAG AA minimum contrast ratio (applied to all text sizes here)

  // Which elements to auto-check:
  // Add data-contrast="auto" to anything critical (recommended),
  // OR expand the selector list below.
  const TARGET_SELECTOR = '[data-contrast="auto"]';

  const clamp = (n, a, b) => Math.min(b, Math.max(a, n));

  const parseColor = (str) => {
    // Handles rgb/rgba only (getComputedStyle returns rgb/rgba in most cases)
    const m = str.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*([.\d]+))?\)/i);
    if (!m) return null;
    return {
      r: +m[1], g: +m[2], b: +m[3],
      a: m[4] === undefined ? 1 : +m[4],
    };
  };

  const srgbToLin = (c) => {
    c /= 255;
    return (c <= 0.04045) ? (c / 12.92) : Math.pow((c + 0.055) / 1.055, 2.4);
  };

  const luminance = ({r,g,b}) => {
    const R = srgbToLin(r), G = srgbToLin(g), B = srgbToLin(b);
    return 0.2126*R + 0.7152*G + 0.0722*B;
  };

  const contrastRatio = (c1, c2) => {
    const L1 = luminance(c1);
    const L2 = luminance(c2);
    const hi = Math.max(L1, L2);
    const lo = Math.min(L1, L2);
    return (hi + 0.05) / (lo + 0.05);
  };

  const blendOver = (fg, bg) => {
    // alpha blend fg over bg
    const a = clamp(fg.a, 0, 1);
    return {
      r: Math.round(fg.r * a + bg.r * (1 - a)),
      g: Math.round(fg.g * a + bg.g * (1 - a)),
      b: Math.round(fg.b * a + bg.b * (1 - a)),
      a: 1
    };
  };

  const findEffectiveBackground = (el) => {
    // Walk up until we find a non-transparent background-color
    let node = el;
    while (node && node !== document.documentElement) {
      const bg = parseColor(getComputedStyle(node).backgroundColor);
      if (bg && bg.a > 0.01) return bg;
      node = node.parentElement;
    }
    // fallback to root background
    const rootBg = parseColor(getComputedStyle(document.documentElement).backgroundColor);
    return rootBg || {r:255,g:255,b:255,a:1};
  };

  const bestBW = (bg) => {
    const black = {r:0,g:0,b:0,a:1};
    const white = {r:255,g:255,b:255,a:1};
    return (contrastRatio(black, bg) >= contrastRatio(white, bg)) ? black : white;
  };

  const fixOne = (el) => {
    const cs = getComputedStyle(el);
    const fg = parseColor(cs.color);
    if (!fg) return;

    let bg = findEffectiveBackground(el);
    // If fg has alpha, approximate blending onto bg
    const effectiveFg = fg.a < 1 ? blendOver(fg, bg) : {r:fg.r,g:fg.g,b:fg.b,a:1};

    const ratio = contrastRatio(effectiveFg, bg);

    if (ratio < MIN_RATIO) {
      const chosen = bestBW(bg);
      el.classList.add('contrast-fix');
      el.style.setProperty('--contrast-fix-color', `rgb(${chosen.r}, ${chosen.g}, ${chosen.b})`);
    } else {
      el.classList.remove('contrast-fix');
      el.style.removeProperty('--contrast-fix-color');
    }
  };

  const scan = () => {
    document.querySelectorAll(TARGET_SELECTOR).forEach(fixOne);
  };

  // Run now, then on resize (layout changes affect backgrounds)
  scan();
  window.addEventListener('resize', () => scan(), {passive:true});

  // Observe DOM changes (new elements injected, class changes, etc.)
  const mo = new MutationObserver(() => scan());
  mo.observe(document.documentElement, {subtree:true, childList:true, attributes:true});
})();
