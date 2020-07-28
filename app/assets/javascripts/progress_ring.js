class ProgressRing extends HTMLElement {
  constructor() {
    super();

    const stroke = this.getAttribute('stroke');
    const radius = this.getAttribute('radius');
    const color = this.getAttribute('color');
    const textColor = this.getAttribute('text-color');
    const textSize = this.getAttribute('text-size');
    const normalizedRadius = radius - stroke * 2;
    this._circumference = normalizedRadius * 2 * Math.PI;
    this._text = "0%";

    this._root = this.attachShadow({mode: 'open'});
    this._root.innerHTML = `
      <svg
        height="${radius * 2}"
        width="${radius * 2}"
       >
         <circle
           stroke="${color || 'white'}"
           stroke-dasharray="${this._circumference} ${this._circumference}"
           style="stroke-dashoffset:${this._circumference}"
           stroke-width="${stroke}"
           fill="#364156"
           r="${normalizedRadius}"
           cx="${radius}"
           cy="${radius}"
        />
        <text
          x="50%" y="50%"
          dominant-baseline="middle"
          text-anchor="middle"
          fill="${textColor || 'white'}"
          font-size="${textSize || '20px'}">
          ${this._text}
        </text>
      </svg>

      <style>
        circle {
          transition: stroke-dashoffset 0.35s;
          transform: rotate(-90deg);
          transform-origin: 50% 50%;
        }
      </style>
    `;
  }

  setProgress(percent) {
    if (percent >= 0 && percent <= 100) {
      const offset = this._circumference - (percent / 100 * this._circumference);
      const circle = this._root.querySelector('circle');
      const text = this._root.querySelector('text');
      circle.style.strokeDashoffset = offset;
      text.innerHTML = `${percent}%`;
    }
  }

  static get observedAttributes() {
    return ['progress'];
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (name === 'progress') {
      this.setProgress(newValue);
    }
  }
}

$(() => window.customElements.define('progress-ring', ProgressRing))
