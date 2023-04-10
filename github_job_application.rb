Carpe Token Bridge UI · Issue #1 · 0lBounties/bounties · GitHub
https://gitcoin.co/issue/28818?mutate_worker_action=approve&worker=mylocyrus
import { getRequestContext } from './request-context.js';
import { getOrCreateClientId } from './client-id.js';
export class AnalyticsClient {
    constructor(options) {
        this.options = options;
    }
    get collectorUrl() {
        return this.options.collectorUrl;
    }
    get clientId() {
        if (this.options.clientId) {
            return this.options.clientId;
        }
        return getOrCreateClientId();
    }
    createEvent(context) {
        return {
            page: location.href,
            title: document.title,
            context: {
                ...this.options.baseContext,
                ...context
            }
        };
    }
    sendPageView(context) {
        const pageView = this.createEvent(context);
        this.send({ page_views: [pageView] });
    }
    sendEvent(type, context) {
        const event = {
            ...this.createEvent(context),
            type
        };
        this.send({ events: [event] });
    }
    send({ page_views, events }) {
        const payload = {
            client_id: this.clientId,
            page_views,
            events,
            request_context: getRequestContext()
        };
        const body = JSON.stringify(payload);
        try {
            if (navigator.sendBeacon) {
                navigator.sendBeacon(this.collectorUrl, body);
                return;
            }
        }
        catch {
        }
        fetch(this.collectorUrl, {
            method: 'POST',
            cache: 'no-cache',
            headers: {
                'Content-Type': 'application/json'
            },
            body,
            keepalive: false
        });
    }
}

manifest.json
{
    "name": "GitHub",
    "short_name": "GitHub",
    "start_url": "/",
    "display": "standalone",
    "icons": [
        {
            "sizes": "114x114",
            "src": "https://github.githubassets.com/apple-touch-icon-114x114.png"
        },
        {
            "sizes": "120x120",
            "src": "https://github.githubassets.com/apple-touch-icon-120x120.png"
        },
        {
            "sizes": "144x144",
            "src": "https://github.githubassets.com/apple-touch-icon-144x144.png"
        },
        {
            "sizes": "152x152",
            "src": "https://github.githubassets.com/apple-touch-icon-152x152.png"
        },
        {
            "sizes": "180x180",
            "src": "https://github.githubassets.com/apple-touch-icon-180x180.png"
        },
        {
            "sizes": "57x57",
            "src": "https://github.githubassets.com/apple-touch-icon-57x57.png"
        },
        {
            "sizes": "60x60",
            "src": "https://github.githubassets.com/apple-touch-icon-60x60.png"
        },
        {
            "sizes": "72x72",
            "src": "https://github.githubassets.com/apple-touch-icon-72x72.png"
        },
        {
            "sizes": "76x76",
            "src": "https://github.githubassets.com/apple-touch-icon-76x76.png"
        },
        {
            "src": "https://github.githubassets.com/app-icon-192.png",
            "type": "image/png",
            "sizes": "192x192"
        },
        {
            "src": "https://github.githubassets.com/app-icon-512.png",
            "type": "image/png",
            "sizes": "512x512"
        }
    ],
    "prefer_related_applications": true,
    "related_applications": [
        {
            "platform": "play",
            "url": "https://play.google.com/store/apps/details?id=com.github.android",
            "id": "com.github.android"
        }
    ]
}
