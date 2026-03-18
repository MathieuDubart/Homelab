# Homelab 🚀

A lightweight, native iOS dashboard to monitor and control your self-hosted Coolify

## Features

- **System Health at a Glance**: Real-time CPU and RAM monitoring via Glances API.
- **Docker Management**: View all running containers, sorted by memory usage.
- **Coolify Integration**: Start, Stop, or Restart your services directly from the app using iOS Swipe Actions.
- **Auto-Mapping**: Automatically links Docker container names to Coolify Service UUIDs.
- **Secure Persistence**: Server URLs and API Tokens are stored locally using `@AppStorage`.

## Installation
### 1. Clone the Repository
```Bash

git clone https://github.com/MathieuDubart/Homelab.git
cd Homelab
```

### 2. Build & Run

  → Connect your iPhone via USB or select a Simulator.
  
  → Ensure your Team is selected in Signing & Capabilities.
  
  → Press Cmd + R to build and run.

## Configuration

## Once the app is launched:

  → Tap the Gear Icon ⚙️ in the top right.
  
  → Enter your Glances/Coolify URL (e.g., https://coolify.yourdomain.com).
  
  → Paste your Coolify API Token.
  
  → The dashboard will automatically start polling data.

## Tech Stack

  → SwiftUI: 100% Declarative UI.
  
  → URLSession: Async/Await for all network calls.
  
  → WidgetKit: (In Progress) For Home Screen glanceable stats.
  
  → AppStorage: Native data persistence.

Built with ❤️ for the self-hosting community.
