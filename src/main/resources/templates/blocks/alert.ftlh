<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function showMessage(message) {
        Swal.fire({
          text: message,
          icon: "success",
          confirmButtonColor: '#e0d8d0'
        });
    }
    function showWarning(warning) {
        Swal.fire({
          text: warning,
          icon: "warning",
          confirmButtonColor: '#e0d8d0'
        });
    }
    function showError(error) {
        Swal.fire({
          text: error,
          icon: "error",
          confirmButtonColor: '#e0d8d0'
        });
    }
</script>

<#if message??>
    <script>
        showMessage("${message}");
    </script>
</#if>
<#if warning??>
    <script>
        showWarning("${warning}");
    </script>
</#if>
<#if error??>
    <script>
        showError("${error}");
    </script>
</#if>
