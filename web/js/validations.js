// Form validation functions
function validateRegistration() {
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    const role = document.getElementById("role").value;

    // Clear previous error messages
    clearErrors();

    let isValid = true;

    // Name validation
    if (name === "") {
        showError("name", "Name is required");
        isValid = false;
    } else if (name.length < 2) {
        showError("name", "Name must be at least 2 characters long");
        isValid = false;
    }

    // Email validation
    if (email === "") {
        showError("email", "Email is required");
        isValid = false;
    } else if (!isValidEmail(email)) {
        showError("email", "Please enter a valid email address");
        isValid = false;
    }

    // Password validation
    if (password === "") {
        showError("password", "Password is required");
        isValid = false;
    } else if (password.length < 8) {
        showError("password", "Password must be at least 8 characters long");
        isValid = false;
    } else if (!hasUpperCase(password)) {
        showError("password", "Password must contain at least one uppercase letter");
        isValid = false;
    } else if (!hasNumber(password)) {
        showError("password", "Password must contain at least one number");
        isValid = false;
    }

    // Confirm password validation
    if (confirmPassword === "") {
        showError("confirmPassword", "Please confirm your password");
        isValid = false;
    } else if (password !== confirmPassword) {
        showError("confirmPassword", "Passwords do not match");
        isValid = false;
    }

    // Role validation
    if (role === "") {
        showError("role", "Please select a role");
        isValid = false;
    }

    return isValid;
}

function validateLogin() {
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value;

    // Clear previous error messages
    clearErrors();

    let isValid = true;

    // Email validation
    if (email === "") {
        showError("email", "Email is required");
        isValid = false;
    } else if (!isValidEmail(email)) {
        showError("email", "Please enter a valid email address");
        isValid = false;
    }

    // Password validation
    if (password === "") {
        showError("password", "Password is required");
        isValid = false;
    }

    return isValid;
}

function validateInternshipForm() {
    const title = document.getElementById("title").value.trim();
    const description = document.getElementById("description").value.trim();
    const requirements = document.getElementById("requirements").value.trim();
    const location = document.getElementById("location").value.trim();
    const duration = document.getElementById("duration").value.trim();

    // Clear previous error messages
    clearErrors();

    let isValid = true;

    // Title validation
    if (title === "") {
        showError("title", "Title is required");
        isValid = false;
    } else if (title.length < 5) {
        showError("title", "Title must be at least 5 characters long");
        isValid = false;
    }

    // Description validation
    if (description === "") {
        showError("description", "Description is required");
        isValid = false;
    } else if (description.length < 50) {
        showError("description", "Description must be at least 50 characters long");
        isValid = false;
    }

    // Requirements validation
    if (requirements === "") {
        showError("requirements", "Requirements are required");
        isValid = false;
    }

    // Location validation
    if (location === "") {
        showError("location", "Location is required");
        isValid = false;
    }

    // Duration validation
    if (duration === "") {
        showError("duration", "Duration is required");
        isValid = false;
    } else if (isNaN(duration) || parseInt(duration) <= 0) {
        showError("duration", "Duration must be a positive number");
        isValid = false;
    }

    return isValid;
}

// Helper functions
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function hasUpperCase(str) {
    return /[A-Z]/.test(str);
}

function hasNumber(str) {
    return /\d/.test(str);
}

function showError(fieldId, message) {
    const field = document.getElementById(fieldId);
    const errorDiv = document.createElement("div");
    errorDiv.className = "invalid-feedback";
    errorDiv.textContent = message;
    
    field.classList.add("is-invalid");
    field.parentNode.appendChild(errorDiv);
}

function clearErrors() {
    // Remove all error messages
    const errorMessages = document.getElementsByClassName("invalid-feedback");
    while (errorMessages.length > 0) {
        errorMessages[0].parentNode.removeChild(errorMessages[0]);
    }

    // Remove invalid class from all fields
    const invalidFields = document.getElementsByClassName("is-invalid");
    while (invalidFields.length > 0) {
        invalidFields[0].classList.remove("is-invalid");
    }
}