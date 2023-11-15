// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import { init as initCommentForm } from "comment_form";

initCommentForm();

// Removing / Disabling ActionText Image / Document Upload functionality
document.addEventListener("trix-initialize", function(event) {
  var toolbar = event.target.toolbarElement;
  var attachmentsButton = toolbar.querySelector(".trix-button-group--file-tools");

  if (attachmentsButton) {
    attachmentsButton.parentNode.removeChild(attachmentsButton);
  }
});

import "trix"
import "@rails/actiontext"
