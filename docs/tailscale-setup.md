# Tailscale Setup Guide

## Overview
Tailscale creates a private mesh VPN (tailnet) connecting all your devices. This lets you reach Mac mini and iMac from anywhere — your phone, laptop, or even the Boox.

## Installation

### Mac mini (automation server)
```bash
# Install via Homebrew
brew install tailscale

# Start the service
sudo tailscaled &

# Authenticate (opens browser)
tailscale up

# Verify
tailscale status
```

### iMac (dev workstation)
Same as Mac mini — `brew install tailscale`, then `tailscale up`.

### iPhone
1. Install **Tailscale** from App Store
2. Open app → Sign in with same account
3. Enable VPN when prompted

### Boox Note Air 3 (Android)
1. Install **Tailscale** from Google Play Store (Boox runs Android)
2. Sign in with same account
3. Enable VPN

### MacBook Pro
```bash
brew install tailscale
tailscale up
```

## Verify Connectivity

After all devices are connected:
```bash
# From any device
tailscale status

# Test Mac mini reachability (from phone or laptop)
ping [mac-mini-tailscale-ip]

# Test SSH access to Mac mini
ssh jakob@[mac-mini-tailscale-ip]
```

## Key Configuration

### Enable MagicDNS
In the Tailscale admin console (login.tailscale.com):
1. Go to DNS settings
2. Enable MagicDNS
3. Now you can use `mac-mini` instead of IP addresses

### Set Mac mini as always-on
The Mac mini should have "Prevent automatic sleeping" enabled in System Settings → Energy Saver. Tailscale will reconnect automatically after any network changes.

## Usage in the AI System

### Mac mini API server
If you run a FastAPI server on Mac mini (for Apple Shortcuts to call):
```python
# On Mac mini
uvicorn api:app --host 0.0.0.0 --port 8080
```
Then from your phone (via Tailscale):
```
http://mac-mini:8080/briefing
```

### Supabase access
Supabase is cloud-hosted, so Tailscale isn't needed for database access. Tailscale is specifically for reaching your local machines (Mac mini file server, iMac Obsidian vault, local scripts).

## Security Notes
- Tailscale uses WireGuard encryption — traffic between devices is end-to-end encrypted
- Free tier supports up to 100 devices (more than enough)
- No port forwarding or firewall changes needed
- Devices are only accessible within your tailnet (not exposed to the internet)
