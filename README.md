Here is the **final cleaned README.md** with **no emojis**, fully formatted and ready for GitHub.

---

# Delivery Tracking Timeline Kit

A plug-and-play Swift Package that provides a complete order tracking system with:

* Amazon-style delivery timeline
* Dynamic shipment events
* City/hub logs
* Admin controls for updating delivery stages
* API-driven hub location selection

---

# Installation (Swift Package Manager)

### Option 1 — Install via GitHub URL

1. Open Xcode → File → Add Package Dependencies
2. Enter:

```
https://github.com/Excelsior-Technologies-Community/IOS_Tracking
```

3. Select branch: `Stages`
4. Add the package to your app target

---

# Importing the Package

```swift
import DeliveryTrackingTimelineKit
```

---

# Core Components

### 1. DeliveryTrackingAdminView

Complete tracking UI + admin controls.
Allows selecting hub locations passed dynamically from API.

### 2. DeliveryTrackingTimelineView

Displays user-facing tracking timeline only.

### 3. TrackingEvent

Represents an event within a stage.

### 4. DeliveryStage

Represents a single stage in the timeline (ordered, packed, shipped, etc.)

---
 
# Dynamic API-Based City Selection

If your app fetches hubs from an API, simply pass them to:

### DeliveryTrackingAdminView

```swift
DeliveryTrackingAdminView(["Mumbai", "Ahmedabad", "Goa"])
```

This will show these exact cities inside the location picker when stages require hub selection.

---

# Customizable Parameters

| Parameter      | Type                | Description            |
| -------------- | ------------------- | ---------------------- |
| `stages`       | `[DeliveryStage]`   | Timeline data          |
| `currentStage` | `DeliveryStageType` | Active stage           |
| `isLoading`    | `Bool`              | Optional loading state |
| `onRefresh`    | `() -> Void`        | Refresh callback       |

---

# Features

* Full Amazon-style tracking timeline
* Admin stage controller
* Hub/city event logs
* Dynamic city list from API
* Expandable event history
* Works with any backend
* Reusable Swift Package
* Supports dark mode
* Built fully in SwiftUI

---

# Recommended Use Cases

This package is useful for:

* E-commerce apps
* Courier/logistics tracking
* Food delivery status tracking
* Order fulfillment dashboards
* Shipment management systems

---

# Testing Example

To quickly test the full admin tracking system with custom cities:

```swift
struct ContentView: View {
    var body: some View {
DeliveryTrackingAdminView(
            stageCities: [
                .inTransit: ["Mumbai", "Goa"],
                .arrivedWarehouse: ["UP", "Bihar"],
                .arrivedCityHub: ["Ahmedabad", "Surat"]
            ]
        )
    }
}
```

 
