function toggleButtonState(commentLength, submitButton) {
    if (commentLength >= 5 && commentLength <= 1000) {
        submitButton.disabled = false;
        submitButton.classList.remove('bg-gray-500', 'hover:bg-gray-600', 'opacity-50');
        submitButton.classList.add('bg-green-500', 'hover:bg-green-600');
    } else {
        submitButton.disabled = true;
        submitButton.classList.remove('bg-green-500', 'hover:bg-green-600');
        submitButton.classList.add('bg-gray-500', 'hover:bg-gray-600', 'opacity-50');
    }
}

export function handleCommentForm() {
  function setupForm() {
    let commentInput = document.getElementById('commentBody');
    let submitButton = document.getElementById('submit_button');
    let charCount = document.getElementById('charCount');

    commentInput.addEventListener('input', function(e) {
      let commentLength = e.target.value.trim().length;
      charCount.textContent = commentLength + '/1000';
      
      charCount.classList.toggle('text-red-500', !(commentLength >= 5 && commentLength <= 1000));

      toggleButtonState(commentLength, submitButton);
    });

    toggleButtonState(commentInput.value.trim().length, submitButton);
  }

  document.addEventListener('turbo:load', setupForm);
  document.addEventListener('turbo:render', setupForm);
};

export function handleCommentDeleteForm() {
  document.addEventListener("click", (event) => {
    const button = event.target.closest('[id^="menu-button-"]');
    if (button) {
      event.stopPropagation();
      const menu = button.parentElement.nextElementSibling;
      menu.style.display = menu.style.display === "none" ? "block" : "none";
    } else {
      document.querySelectorAll('[role="menu"]').forEach((menu) => {
        menu.style.display = "none";
      });
    }
  });
};

export function init() {
  handleCommentForm();
  handleCommentDeleteForm();
}