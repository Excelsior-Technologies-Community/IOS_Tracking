 
# 🛠 **Installation (Swift Package Manager)**

### **Option 1 — Add using GitHub URL (Recommended)**

1. Open **Xcode**
2. Go to
   **File → Add Package Dependencies**
3. Enter the package URL:

```
https://github.com/noman1303/SmartBillios-Excelsior-Technologies-Community-IOS_Tracking
```

4. Select branch: **Stages**
5. Add package to your app target

Done! 🎉

---

### **Option 2 — Add as Local Package (For Testing)**

1. Go to
   **File → Add Package Dependencies**
2. Click **Add Local…**
3. Select the folder:

```
SmartBillios-Excelsior-Technologies-Community-IOS_Tracking
```

---

# 📌 **Importing the Package**

In any SwiftUI file, simply:

```swift
import DeliveryTrackingTimelineKit
```

---

# 📦 **Data Models**

## **DeliveryStage**

```swift
DeliveryStage(
    type: .inTransit,
    timestamp: Date(),
    status: .current,
    events: [...]
)
```

## **TrackingEvent**

```swift
TrackingEvent(
    city: "Ahmedabad",
    hubName: "Gujarat Facility",
    description: "Departed from Ahmedabad Hub",
    arrivalTime: Date(),
    departureTime: nil
)
```

---

# 🧪 **Usage Example (No API Needed)**

You can test this package using **static dummy data**.

### **Step 1 — Create sample tracking data**

```swift
let sampleStages: [DeliveryStage] = [
    DeliveryStage(type: .ordered, status: .completed),
    DeliveryStage(type: .packed, status: .completed),
    DeliveryStage(type: .shipped, status: .completed),
    DeliveryStage(
        type: .inTransit,
        status: .current,
        events: [
            TrackingEvent(
                city: "Ahmedabad",
                hubName: "Gujarat Facility",
                description: "Departed from Ahmedabad Hub"
            )
        ]
    ),
    DeliveryStage(type: .arrivedCityHub, status: .upcoming),
    DeliveryStage(type: .arrivedWarehouse, status: .upcoming),
    DeliveryStage(type: .outForDelivery, status: .upcoming),
    DeliveryStage(type: .delivered, status: .upcoming)
]
```

---

### **Step 2 — Display the tracking timeline UI**

```swift
DeliveryTrackingTimelineView(
    stages: sampleStages,
    currentStage: .inTransit,
    isLoading: false,
    onRefresh: {
        print("Refreshing…")
    }
)
```

---

# 🎛 **Customizable Parameters**

| Parameter      | Type                | Description                |
| -------------- | ------------------- | -------------------------- |
| `stages`       | `[DeliveryStage]`   | Tracking data for timeline |
| `currentStage` | `DeliveryStageType` | Highlights active stage    |
| `isLoading`    | `Bool`              | Shows loader in header     |
| `onRefresh`    | `() -> Void`        | Optional refresh callback  |

---

# 🔥 Features

### ✔ Amazon-style tracking UI

### ✔ Fully reusable Swift Package

### ✔ Works with static or dynamic data

### ✔ Expandable shipment logs

### ✔ Minimal setup

### ✔ Supports Dark Mode & accessibility

### ✔ SwiftUI 100%

---

# 🧩 **When Should Developers Use This Package?**

This package is ideal for:

* E-commerce apps
* Courier/logistics apps
* Food delivery tracking
* Order management systems
* Any app requiring timeline progress UI

---

# 🤝 **Contribution**

Feel free to contribute!
Open a PR or Issue on GitHub.

---
 
