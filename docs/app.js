const $q = document.getElementById("q");
const $results = document.getElementById("results");
const $meta = document.getElementById("meta");

let data = [];

// Configuration constants
const MAX_RESULTS = 50;
const MAX_TAGS_DISPLAY = 6;
const PHRASE_MATCH_SCORE = 10;
const MAX_TOKEN_HITS = 20;
const DEBOUNCE_MS = 150;

/**
 * Scores how well a query matches the given text.
 * 
 * Scoring algorithm:
 * - Phrase match: +10 points if the exact query appears in the text
 * - Token matches: For each query word, count occurrences (capped at 20 per token)
 * 
 * @param {string} query - The search query
 * @param {string} text - The text to search in
 * @returns {number} The match score (higher is better, 0 means no match)
 */
function scoreMatch(query, text) {
  if (!query) return 0;
  const q = query.toLowerCase().trim();
  if (!q) return 0;

  const t = (text || "").toLowerCase();
  if (!t) return 0;

  // Simple scoring: phrase > token hits
  let score = 0;
  if (t.includes(q)) score += PHRASE_MATCH_SCORE;

  const tokens = q.split(/\s+/).filter(Boolean);
  for (const tok of tokens) {
    const hits = t.split(tok).length - 1;
    score += Math.min(hits, MAX_TOKEN_HITS);
  }
  return score;
}

function render(query) {
  const q = (query || "").trim();
  const rows = data
    .map(item => {
      const text = item.text || item.snippet || "";
      const s = scoreMatch(q, `${item.title}\n${item.caseId}\n${(item.tags || []).join(" ")}\n${text}`);
      return { item, s };
    })
    .filter(x => q ? x.s > 0 : true)
    .sort((a,b) => b.s - a.s)
    .slice(0, MAX_RESULTS);

  $meta.textContent = data.length
    ? `${rows.length} result(s) shown • ${data.length} document(s) indexed`
    : "Loading index…";

  $results.innerHTML = rows.map(({item, s}) => {
    const tags = (item.tags || []).slice(0, MAX_TAGS_DISPLAY);
    const hasMoreTags = (item.tags || []).length > MAX_TAGS_DISPLAY;
    const ocr = item.ocrNeeded ? `<span class="badge">OCR needed</span>` : "";
    const ok = item.ok ? "" : `<span class="badge">Index error</span>`;
    const err = item.error ? `<div class="snip">Index error: ${item.error}</div>` : "";
    return `
      <div class="card">
        <h3>${escapeHtml(item.title || item.caseId || "Untitled")}</h3>
        <div class="badges">
          <span class="badge">${escapeHtml(item.caseId || "")}</span>
          ${tags.map(t => `<span class="badge">${escapeHtml(t)}</span>`).join("")}
          ${hasMoreTags ? `<span class="badge">+${(item.tags || []).length - MAX_TAGS_DISPLAY} more</span>` : ""}
          ${ocr}
          ${ok}
          ${q ? `<span class="badge">score: ${s}</span>` : ""}
        </div>
        ${item.snippet ? `<div class="snip">${escapeHtml(item.snippet)}</div>` : ""}
        ${err}
        <div class="actions">
          <a class="btn primary" href="${sanitizeUrl(item.url)}" target="_blank" rel="noopener">Open PDF</a>
        </div>
      </div>
    `;
  }).join("");
}

function escapeHtml(s) {
  return (s || "").replace(/[&<>"'`]/g, c => ({
    "&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#039;","`":"&#96;"
  }[c]));
}

/**
 * Sanitizes a URL to prevent XSS attacks.
 * Only allows http:, https:, and relative URLs.
 * 
 * @param {string} url - The URL to sanitize
 * @returns {string} The sanitized URL or "#" if invalid
 */
function sanitizeUrl(url) {
  if (!url) return "#";
  const trimmed = String(url).trim();
  if (!trimmed) return "#";
  
  // Allow relative URLs
  if (trimmed.startsWith("/") || trimmed.startsWith("./") || trimmed.startsWith("../")) {
    return trimmed;
  }
  
  // Allow only http: and https: protocols
  try {
    const parsed = new URL(trimmed, window.location.href);
    if (parsed.protocol === "http:" || parsed.protocol === "https:") {
      return trimmed;
    }
  } catch (e) {
    // Invalid URL
  }
  
  return "#";
}

async function init() {
  // Add ARIA attributes for accessibility
  $q.setAttribute("aria-label", "Search documents");
  $q.setAttribute("role", "searchbox");
  $results.setAttribute("role", "region");
  $results.setAttribute("aria-live", "polite");
  $results.setAttribute("aria-label", "Search results");
  
  let res;
  try {
    res = await fetch("./data/index.json");
  } catch (err) {
    throw new Error("Failed to fetch index.json: " + (err && err.message ? err.message : String(err)));
  }

  if (!res.ok) {
    throw new Error(`Failed to fetch index.json: ${res.status} ${res.statusText}`);
  }

  try {
    data = await res.json();
  } catch (err) {
    throw new Error("Failed to parse index.json: " + (err && err.message ? err.message : String(err)));
  }
  
  $meta.textContent = `${data.length} document(s) indexed`;
  render("");
}

/**
 * Debounces a function call.
 * @param {Function} func - The function to debounce
 * @param {number} wait - The debounce delay in milliseconds
 * @returns {Function} The debounced function
 */
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

const debouncedRender = debounce((value) => render(value), DEBOUNCE_MS);

$q.addEventListener("input", () => debouncedRender($q.value));
init().catch(err => {
  $meta.textContent = "Failed to load index.json";
  $results.innerHTML = `<div class="card"><div class="snip">${escapeHtml(String(err))}</div></div>`;
});
