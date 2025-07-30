# CanvasQuick

CanvasQuick is a modern, lightweight Flutter mobile application designed to provide a streamlined visual studio environment for displaying and managing images. With a focus on intuitive interaction, content control, and extensible canvas editing, CanvasQuick is ideal for creators and editors who want quick and easy tools to manage visual content.

---

## 📱 Features

### 🖼️ Image Canvas
- Displays a full-screen image with optional background layers:
  - **Background Image**
  - **Background Color**
  - **Background Video File**

### 🎛️ Interactive Top Menu
- **Back / Cancel Navigation**
- **Expandable Action Menu** (toggleable visibility)
- **Pin as Main Page**:
  - Highlights the selected canvas as the main view
  - Includes visual cue (icon background)
  - Confirmation dialog to avoid accidental changes
- **Unpublish Functionality**:
  - Reverts the content to a draft state
  - Navigates user to the draft gallery (`ImagesScreen`)
  - Confirmation dialog included

### 🧰 Bottom Menu
- Custom `bottomMenu()` widget for canvas-related tools and interactions (configurable).

### 🧩 Edit Items Support *(Extensible Feature)*
- Canvas accepts a list of `EditItem` objects (e.g., stickers, text, shapes).
- Placeholder for future editing capabilities.

### 📦 Asset Management
- Utilizes **SVG icons** via `flutter_svg` for sharp and scalable UI.
- Supports media layering with various input types.

---

## 🧭 Navigation Architecture

- Built using Flutter’s `Navigator` for seamless routing and pop-up dialogs.
- Clean and modular widget structure to support multiple view states.
