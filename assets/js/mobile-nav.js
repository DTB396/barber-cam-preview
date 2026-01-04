// Barber Cam — Mobile Nav Behavior
// Additive only. Does not modify layout or animations.

(function () {
  const drawer = document.querySelector('.mobile-nav');
  const toggle = document.querySelector('.mobile-nav-toggle');
  const links = document.querySelectorAll('.mobile-nav a');

  if (!drawer || !toggle) return;

  function closeNav() {
    drawer.classList.remove('open');
    toggle.setAttribute('aria-expanded', 'false');
    document.body.style.overflow = '';
    toggle.focus?.();
  }

  function openNav() {
    drawer.classList.add('open');
    toggle.setAttribute('aria-expanded', 'true');
    document.body.style.overflow = 'hidden';
  }

  toggle.addEventListener('click', () => {
    drawer.classList.contains('open') ? closeNav() : openNav();
  });

  // Close on link click (including #anchors)
  links.forEach(link => {
    link.addEventListener('click', () => {
      closeNav();
    });
  });

  // Close on hash change (backup for anchor navigation)
  window.addEventListener('hashchange', closeNav);
  window.addEventListener('popstate', closeNav);
})();
