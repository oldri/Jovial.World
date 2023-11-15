function toggleButtonState(commentLength, submitButton) {
  if (commentLength >= 1 && commentLength <= 1000) {
    submitButton.disabled = false;
    submitButton.classList.remove(
      "bg-gray-500",
      "hover:bg-gray-600",
      "opacity-50"
    );
    submitButton.classList.add("bg-green-500", "hover:bg-green-600");
  } else {
    submitButton.disabled = true;
    submitButton.classList.remove("bg-green-500", "hover:bg-green-600");
    submitButton.classList.add(
      "bg-gray-500",
      "hover:bg-gray-600",
      "opacity-50"
    );
  }
}

export function handleCommentForm() {
  function setupForm() {
    const commentInput = document.getElementById("commentContent");
    const submitButton = document.getElementById("submit_button");
    const charCount = document.getElementById("charCount");

    commentInput.addEventListener("input", function (e) {
      let commentLength = e.target.value.trim().length;
      charCount.textContent = commentLength + "/1000";

      charCount.classList.toggle(
        "text-red-500",
        !(commentLength >= 1 && commentLength <= 1000)
      );

      toggleButtonState(commentLength, submitButton);
    });

    toggleButtonState(commentInput.value.trim().length, submitButton);
  }

  document.addEventListener("turbo:load", setupForm);
  document.addEventListener("turbo:render", setupForm);
}

export function handleCommentDeleteForm() {
  function handleClick(event) {
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
  }

  document.removeEventListener("click", handleClick);
  document.addEventListener("click", handleClick);
}

export function handleCommentEditForm() {
  function handleClick(event) {
    const editButton = event.target.closest(".edit-dropdown-button");
    if (editButton) {
      const commentId = editButton.getAttribute("data-comment-id");
      const displayDiv = document.getElementById(`comment-${commentId}-display`);
      const editDiv = document.getElementById(`comment-${commentId}-edit`);

      if (displayDiv && editDiv) {
        displayDiv.style.display = displayDiv.style.display === "none" ? "block" : "none";
        editDiv.style.display = editDiv.style.display === "none" ? "block" : "none";

        const textarea = editDiv.querySelector("textarea");
        const sendButton = editDiv.querySelector("input[type='submit']");

        if (textarea && sendButton) {
          textarea.focus();
          const length = textarea.value.length;
          textarea.setSelectionRange(length, length);

          textarea.addEventListener('input', function() {
            sendButton.disabled = textarea.value.trim().length < 1;
          });

          sendButton.disabled = textarea.value.trim().length < 1;
        }
      }
    }
  }

  function setupForm() {
    document.removeEventListener("click", handleClick);
    document.addEventListener("click", handleClick);
  }

  document.removeEventListener("turbo:render", setupForm);
  document.addEventListener("turbo:render", setupForm);
}

export function init() {
  handleCommentForm();
  handleCommentDeleteForm();
  handleCommentEditForm();
}
