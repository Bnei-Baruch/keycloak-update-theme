<#macro content>
<div class="text-gray-500 text-sm mt-10">
    <p class="text-center">© <span id="footer-year"></span> ${msg("companyName")}. All Rights Reserved.</p>
</div>
<script>
    document.getElementById("footer-year").textContent = new Date().getFullYear();
</script>
</#macro>
