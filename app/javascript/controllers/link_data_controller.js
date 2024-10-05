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
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    // This should send data to our backend 
    const linkClicked = event.target.closest('a')

    let url = linkClicked.href;
    const anchorText = linkClicked.textContent.trim();
    const referrer = document.referrer;
    const userAgent = navigator.userAgent;

    // Handle internal links
    const fragment = url.match(/(#\w*)/)
    if (fragment) {
      url = url.match(/(.*?)(?=#)/)[0];
    }

    try {
      const response = await fetch("/link_clicks", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({
          url: url,
          anchor_text: anchorText,
          referrer: referrer,
          user_agent: userAgent
        }),
      })
      console.log(response)
    } catch (error) {
      console.log('Failed to track click: ', error)
    }
  }
}
