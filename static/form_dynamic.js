async function toggleDocket() {
    const docketField = document.getElementById("docket_number");
    const mode = document.querySelector("input[name='docket_mode']:checked").value;

    if (mode === "manual") {
        docketField.removeAttribute("readonly");
    } else {
        docketField.setAttribute("readonly", true);
        docketField.value = await generateDocketNumber();
    }
}


async function generateDocketNumber(dateValue = null) {
    const date = dateValue || document.getElementById("date_field").value;
    const crimeSelect = $("#offenses");
    if (!date) return "";

    try {
        const selectedCrimes = crimeSelect.val() || [];
        const count = selectedCrimes.length;

        // Pass count correctly
        const response = await fetch(`/api/next-serial?date=${date}&count=${count}`);
        const data = await response.json();

        if (data.error) {
            console.error("Server error:", data.error);
            return "";
        }

        const prefix = data.prefix;
        const serials = data.serials;  // <-- the only source of truth

        let docket = "";

        if (serials.length === 1) {
            docket = `${prefix}-${serials[0]}`;
        } else if (serials.length === 2) {
            docket = `${prefix}-${serials[0]}-${serials[1]}`;
        } else {
            docket = prefix;
        }

        document.getElementById("docket_number").value = docket;
        return docket;

    } catch (err) {
        console.error("Fetch error:", err);
        return "";
    }
}


$("#offenses").on("change", () => generateDocketNumber());
$("#date_field").on("change", () => generateDocketNumber());


function removePerson(button) {
    const personBox = button.closest('.person-box');
    
    // Select all inputs, textareas, and selects within this person box
    const inputs = personBox.querySelectorAll('input, textarea, select');
    
    // Check if any of them contain a value (not empty or default)
    let hasData = false;
    inputs.forEach(input => {
        if (input.type === 'checkbox' || input.type === 'radio') {
            if (input.checked) hasData = true;
        } else if (input.value && input.value.trim() !== '') {
            hasData = true;
        }
    });

    // If the form has data, confirm before removing
    if (hasData) {
        const confirmDelete = confirm("This person's form contains data. Are you sure you want to remove it?");
        if (!confirmDelete) return; // cancel removal
    }

    // Proceed with removal
    personBox.remove();
}

function addPerson(type) {
    const container = document.getElementById(`${type}-container`);
    const count = container.querySelectorAll('.person-box').length;
    const newIndex = count;

    const html = `
    <div class="person-box">
        <input class="input-field2" name="${type}s-${newIndex}-first_name" placeholder="First Name">
        <input class="input-field2" name="${type}s-${newIndex}-last_name" placeholder="Last Name">
        <input class="input-field2" name="${type}s-${newIndex}-middle_name" placeholder="Middle Name">
        <select class="input-field2" style="width: 100%;" name="${type}s-${newIndex}-suffix">
            <option value="">Suffix</option>
            <option value="Jr.">Jr.</option>
            <option value="Sr.">Sr.</option>
            <option value="II">II</option>
            <option value="III">III</option>
            <option value="IV">IV</option>
        </select>
        <input class="input-field2 birth-date" name="${type}s-${newIndex}-birth_date" type="date">
        <select class="input-field2" style="width: 100%;" name="${type}s-${newIndex}-sex">
            <option value="">Select Sex</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <input class="input-field2" name="${type}s-${newIndex}-street" placeholder="Street">
        <input class="input-field2" name="${type}s-${newIndex}-barangay" placeholder="Barangay">
        <input class="input-field2" name="${type}s-${newIndex}-municipality" placeholder="Municipality">
        <input class="input-field2" name="${type}s-${newIndex}-province" placeholder="Province">
        <input class="input-field2" name="${type}s-${newIndex}-region" placeholder="Region">
        <button type="button" class="remove-btn" onclick="removePerson(this)">Remove</button>
    </div>
    `;
    container.insertAdjacentHTML('beforeend', html);

    const newDateInput = container.querySelector('.person-box:last-child .birth-date');
    const today = new Date();
    const cutoff = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
    newDateInput.max = cutoff.toISOString().split('T')[0];
}

function getDateCodeParts(dateStr) {
    const date = new Date(dateStr);
    const yearCode = String(date.getFullYear()).slice(-2);
    const monthCode = String.fromCharCode(65 + date.getMonth()); // A = Jan, B = Feb, ...
    return `${yearCode}${monthCode}`;
}

async function syncDocketFromDate() {
    const mode = document.querySelector("input[name='docket_mode']:checked").value;
    if (mode === "auto") {
        await toggleDocket();
    }
}

window.addEventListener("DOMContentLoaded", async () => {
    const today = new Date().toISOString().split("T")[0];
    const dateField = document.getElementById("date_field");
    if (dateField && !dateField.value) {
        dateField.value = today;
    }

    await toggleDocket();
});

$(document).ready(function() {
    var $crimes = $('#offenses');

    $crimes.select2({
        placeholder: "Search and add crimes",
        ajax: {
            url: '/search_offense',
            dataType: 'json',
            delay: 250,
            data: function (params) { return { q: params.term }; },
            processResults: function (data) { return { results: data }; },
            cache: true
        },
        tags: false,
        multiple: true,
        width: 'resolve'
    });
});
