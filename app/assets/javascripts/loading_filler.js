class LoadingFiller extends HTMLElement {
  constructor() {
    super();
  }

  connectedCallback() {
    this.outerHTML = `
      <div class='loading-filler d-flex h-100 align-items-center justify-content-center'>
        <div class="spinner-grow text-primary" role="status">
          <span class="sr-only">Loading...</span>
        </div>
      </div>
    `;
  }
}

$(() => window.customElements.define('loading-filler', LoadingFiller))
