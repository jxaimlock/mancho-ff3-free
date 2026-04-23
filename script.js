// Modified script with GUI title and removed sections

function initGUI() {
    // Set the title of the GUI
    setTitle("MANCHO (free)");
    
    // Initialize the jersey customizer
    initJerseyCustomizer();
}

function initJerseyCustomizer() {
    // Code for jersey customization goes here
    // ... (existing code)
    
    // Button for applying customization
    createButton("Apply Jersey Customization", applyCustomization);
}

function applyCustomization() {
    // Code to apply jersey customizations
}

// Call the initGUI function to start the application
initGUI();