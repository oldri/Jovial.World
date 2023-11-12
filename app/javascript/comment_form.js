export function handleCommentForm() {
    document.addEventListener('turbo:load', function() {
        var commentInput = document.getElementById('commentBody');
        var submitButton = document.getElementById('submit_button');
        var charCount = document.getElementById('charCount');

        commentInput.addEventListener('input', function(e) {
            var commentLength = e.target.value.trim().length;
            charCount.textContent = commentLength + '/1000';
            
            charCount.classList.toggle('text-red-500', !(commentLength >= 5 && commentLength <= 1000));

            if (commentLength >= 5 && commentLength <= 1000) {
                submitButton.disabled = false;
                submitButton.classList.remove('bg-gray-500', 'hover:bg-gray-600', 'opacity-50');
                submitButton.classList.add('bg-green-500', 'hover:bg-green-600');
            } else {
                submitButton.disabled = true;
                submitButton.classList.remove('bg-green-500', 'hover:bg-green-600');
                submitButton.classList.add('bg-gray-500', 'hover:bg-gray-600', 'opacity-50');
            }
        });

        if (commentInput.value.trim().length >= 5 && commentInput.value.trim().length <= 1000) {
            submitButton.disabled = false;
            submitButton.classList.remove('bg-gray-500', 'hover:bg-gray-600', 'opacity-50');
            submitButton.classList.add('bg-green-500', 'hover:bg-green-600');
        }
    });
}