// External libraries
import "@hotwired/turbo-rails";
import "trix";
import "@rails/actiontext";

// Local modules
import "controllers";
import { init as initCommentForm } from "comment_form";

// Initialize local modules
initCommentForm();
initTrix();

// Function definitions
function initTrix() {
  document.addEventListener("trix-initialize", function (event) {
    var toolbar = event.target.toolbarElement;
    var attachmentsButton = toolbar.querySelector(".trix-button-group--file-tools");

    if (attachmentsButton) {
      attachmentsButton.parentNode.removeChild(attachmentsButton);
    }
  });
}