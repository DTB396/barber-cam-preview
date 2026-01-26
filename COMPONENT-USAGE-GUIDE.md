# Component Usage Guide

Quick reference for using the reusable components in BarberX Legal Tech.

## Footer Component

### Basic Usage
```html
{% include 'components/footer.html' %}
```

### Features
- 4-column responsive grid (Company Info, Product, Company, Legal)
- Social media links (Twitter, GitHub, LinkedIn)
- Copyright and disclaimer text
- BarberX branding colors
- Mobile-responsive (stacks on small screens)

### Customization
Edit `templates/components/footer.html` to:
- Update social media links
- Modify footer sections
- Change copyright text
- Add/remove footer columns

---

## Navbar Component

### Basic Usage
```html
{% include 'components/navbar.html' %}
```

### Features
- Sticky navigation bar
- BarberX logo with barber pole icon
- Product navigation with dropdowns
- User authentication state detection
- Mobile hamburger menu
- User profile dropdown (when logged in)

### Authentication States
**Logged Out:**
- Shows "Sign In" and "Get Started" buttons

**Logged In:**
- Shows user avatar with first letter of name/email
- Displays user's tier badge
- Dropdown with: Dashboard, API Keys, Settings, Logout

### Customization
Edit `templates/components/navbar.html` to:
- Add/remove navigation links
- Modify dropdown menu items
- Update logo/branding
- Change color scheme

---

## Modal Component

### Basic Usage
```html
{% include 'components/modal.html' with 
    modal_id='myModal',
    modal_title='Confirm Action',
    modal_content='Are you sure you want to proceed?',
    confirm_button_text='Yes, Continue',
    cancel_button_text='No, Cancel',
    confirm_action='handleConfirm()'
%}
```

### JavaScript Control
```javascript
// Open modal
openModal('myModal');

// Close modal
closeModal('myModal');
```

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `modal_id` | string | 'Default' | Unique identifier for the modal |
| `modal_title` | string | 'Modal Title' | Header text |
| `modal_content` | string/HTML | 'Modal content...' | Body content |
| `show_cancel_button` | boolean | true | Show cancel button |
| `show_confirm_button` | boolean | true | Show confirm button |
| `cancel_button_text` | string | 'Cancel' | Cancel button label |
| `confirm_button_text` | string | 'Confirm' | Confirm button label |
| `confirm_action` | string | closeModal() | JavaScript function for confirm |

### Advanced Example
```html
{% include 'components/modal.html' with
    modal_id='deleteConfirm',
    modal_title='Delete Analysis',
    modal_content='<p class="text-danger"><strong>Warning:</strong> This action cannot be undone.</p><p>Are you sure you want to delete this analysis?</p>',
    confirm_button_text='Delete Forever',
    confirm_action='deleteAnalysis()'
%}
```

### Features
- Click outside or press ESC to close
- Smooth fade/scale animations
- Backdrop blur effect
- Mobile-responsive (slides up from bottom on mobile)
- Accessible (ARIA labels, focus management)

---

## Onboarding Tour Component

### Basic Usage
```html
{% include 'components/onboarding-tour.html' %}
```

### Features
- Interactive step-by-step guide for new users
- Spotlight effect on target elements
- Tier-aware content
- Skip and Next buttons
- Progress indicator
- Auto-detects user tier

### Note
This component is already integrated in `templates/auth/dashboard.html`.

---

## Tier Upgrade Card Component

### Basic Usage
```html
{% include 'components/tier-upgrade-card.html' %}
```

### With Custom Content
```html
{% include 'components/tier-upgrade-card.html' with
    title='Unlock Premium Features',
    description='Upgrade to Professional for unlimited analysis and priority support.',
    benefits=[
        'Unlimited BWC analysis',
        'Priority 24/7 support',
        'Advanced analytics',
        'API access'
    ]
%}
```

### Parameters
- `title` - Card heading (optional)
- `description` - Upgrade message (optional)
- `benefits` - List of benefit strings (optional)

### Features
- Automatically detects current user tier
- Shows contextual upgrade path
- Visual benefit list with checkmarks
- Prominent CTA button

---

## Usage Meter Component

### Basic Usage
```html
{% include 'components/usage-meter.html' with
    resource_name='api_calls',
    title='API Calls',
    current=750,
    limit=1000
%}
```

### Parameters
- `resource_name` - Identifier for the resource
- `title` - Display name
- `current` - Current usage count
- `limit` - Maximum limit (-1 for unlimited)
- `icon_svg` - Custom SVG icon (optional)

### Features
- Visual progress bar
- Color-coded status (warning at 75%, critical at 90%)
- Unlimited badge for unlimited tiers
- Usage percentage calculation
- Contextual messaging

---

## Component File Locations

```
templates/components/
├── footer.html          ✅ NEW - Reusable footer
├── navbar.html          ✅ NEW - Navigation bar
├── modal.html           ✅ NEW - Modal dialog
├── onboarding-tour.html ✅ Existing - User onboarding
├── tier-upgrade-card.html ✅ Existing - Upgrade prompts
└── usage-meter.html     ✅ Existing - Usage tracking
```

---

## Best Practices

### 1. **Consistent Inclusion**
Use the same component across all pages for consistency:
```html
<!-- In every page -->
{% include 'components/navbar.html' %}

<!-- Page content -->

{% include 'components/footer.html' %}
```

### 2. **Modal IDs**
Always use unique modal IDs to avoid conflicts:
```html
<!-- Good ✓ -->
{% include 'components/modal.html' with modal_id='confirmDelete' %}
{% include 'components/modal.html' with modal_id='editProfile' %}

<!-- Bad ✗ -->
{% include 'components/modal.html' %}  <!-- Uses default ID -->
{% include 'components/modal.html' %}  <!-- Conflicts! -->
```

### 3. **Component Customization**
When you need heavy customization:
- Copy the component file
- Rename it (e.g., `modal-custom.html`)
- Modify as needed
- Include the custom version

### 4. **Keep Components Generic**
Don't hardcode page-specific content in shared components. Use parameters instead:
```html
<!-- Good ✓ -->
{% include 'components/modal.html' with modal_title=analysis.name %}

<!-- Bad ✗ -->
<!-- Hardcoding "Analysis #123" in modal.html -->
```

---

## Troubleshooting

### Component Not Rendering
1. Check file path: `templates/components/[component].html`
2. Verify include syntax: `{% include 'components/[component].html' %}`
3. Check for syntax errors in the component file

### Styles Not Applied
1. Ensure CSS is in `<style>` block within component
2. Check for CSS conflicts with page styles
3. Use browser DevTools to inspect elements

### JavaScript Not Working
1. Verify script is in `<script>` block within component
2. Check browser console for errors
3. Ensure unique IDs for multiple instances

---

**Last Updated**: January 25, 2026  
**BarberX Legal Tech Platform**
