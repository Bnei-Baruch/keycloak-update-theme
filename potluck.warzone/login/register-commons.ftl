<#macro termsAcceptance>
    <#if termsAcceptanceRequired??>

        <#--  TODO HERE  -->
        <div class="form-group text-gray-800">
            <div id="kc-registration-terms-text">
                ${msg("termsTitle")}, <a class="text-gray-500 hover:text-purple-600 transition" href=client.attributes.tosUri >${kcSanitize(msg("termsText", client.name))?no_esc}</a>
            </div>
        </div>
        <div class="form-group text-gray-800">
            <div>
                <input 
                    type="checkbox" 
                    id="termsAccepted" 
                    name="termsAccepted" 
                    class="rounded mb-1 focus:outline-none outline-none border border-purple-400 text-purple-600 ring-1 ring-purple-300/25 focus:ring-purple-300"
                    aria-invalid="<#if messagesPerField.existsError('termsAccepted')>true</#if>"
                />
                <label for="termsAccepted">${msg("acceptTerms")}</label>
            </div>
            <#if messagesPerField.existsError('termsAccepted')>
                <span id="input-error-terms-accepted" class="text-sm text-red-600" aria-live="polite">
                    ${kcSanitize(messagesPerField.get('termsAccepted'))?no_esc}
                </span>
            </#if>
        </div>
    </#if>
</#macro>
