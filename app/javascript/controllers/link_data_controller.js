import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="link-data"
export default class extends Controller {
  connect() {
    // Attach a data action to all links on the page when controller is connected
    const links = document.querySelectorAll("a")

    links.forEach(link => {
      link.setAttribute("data-action", "click->link-data#trackClick");
    });

  }

  async trackClick(event) {
    event.preventDefault()
    // This should send data to our backend 
    const linkClicked = event.target.closest('a')

    const url = linkClicked.href;
    const anchorText = linkClicked.textContent.trim();
    const referrer = document.referrer;

    console.log({ url, anchorText, referrer });
  }
}
