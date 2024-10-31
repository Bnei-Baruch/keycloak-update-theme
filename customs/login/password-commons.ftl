<#macro logoutOtherSessions>
    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
        <div class="${properties.kcFormOptionsWrapperClass!}">
            <div>
                <input 
                    class="rounded mb-0.5 focus:outline-none outline-none border border-purple-400 text-purple-600 ring-1 ring-purple-300/25 focus:ring-purple-300"
                    type="checkbox" 
                    id="logout-sessions" 
                    name="logout-sessions" 
                    value="on" 
                    checked
                >
                <label class="pf-v5-c-check__label text-gray-800 ml-2" for="logout-sessions">
                    ${msg("logoutOtherSessions")}
                </label>
            </div>
        </div>
    </div>
</#macro>
