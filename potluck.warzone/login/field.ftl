<#--  INPUT_LABEL  -->
<#macro group name label error="" required=false>
  <div class="type-input-label">
    <div class="text-sm mb-2">
      <label for="${name}">
          <span class="text-gray-700">
            ${label}
          </span>
          <#if required>
            <span class="text-red-600" aria-hidden="true">&#42;</span>
          </#if>
      </label>
    </div>

    <#nested>

    <div id="input-error-client-${name}"></div>
    <#if error?has_content>
      <div class="text-sm text-red-600" id="input-error-${name}" aria-live="polite">
        <span>${error}</span>
      </div>
    </#if>
  </div>
</#macro>

<#macro errorIcon error="">
  <#if error?has_content>
    <span class="text-red-600 flex">*</span>
  </#if>
</#macro>

<#--  INPUT_TEXT  -->
<#macro input name label value="" required=false autocomplete="off" fieldName=name autofocus=false>
  <#assign error=kcSanitize(messagesPerField.get(fieldName))?no_esc>
  <@group name=name label=label error=error required=required>
    <div>
        <input class="px-4 py-2.5 bg-white text-gray-800 rounded-lg border border-gray-300 focus:outline-none focus:border-brand-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-brand-500 w-full" id="${name}" name="${name}" value="${value}" type="text" autocomplete="${autocomplete}" <#if autofocus>autofocus</#if> aria-invalid="<#if error?has_content>true</#if>"/>
    </div>
  </@group>
</#macro>

<#--  INPUT_PASSWORD  -->
<#macro password name label value="" required=false forgotPassword=false fieldName=name autocomplete="off" autofocus=false>
  <#assign error=kcSanitize(messagesPerField.get(fieldName))?no_esc>
  <@group name=name label=label error=error required=required>
    <div class="w-full">
        <input class="px-4 py-2.5 bg-white text-gray-800 rounded-lg border border-gray-300 focus:outline-none focus:border-brand-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-brand-500 w-full" id="${name}" name="${name}" value="${value}" type="password" autocomplete="${autocomplete}" <#if autofocus>autofocus</#if> aria-invalid="<#if error?has_content>true</#if>"/>
    </div>
    <div class="mt-2 flex justify-start">
        <button class="text-gray-600 hover:text-brand-600 transition-colors relative group font-medium flex items-center gap-2" type="button" aria-label="${msg('showPassword')}"
                aria-controls="${name}" data-password-toggle
                data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
            <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" class="w-6 h-6" viewBox="0 0 24 24">
                <path fill="currentColor" d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>
            </svg>
            <span class="text-sm">Show password</span>
        </button>
    </div>
      <#if forgotPassword>
        <div class="mt-4 flex items-center justify-end" aria-live="polite">
            <span class="text-gray-600 hover:text-brand-600 transition">
                <a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
            </span>
        </div>
      </#if>
  </@group>
</#macro>

<#--  INPUT_CHECKBOX  -->
<#macro checkbox name label value=false required=false>
  <div>
    <label for="${name}">
      <input
        class="rounded mb-1 focus:outline-none outline-none border border-brand-400 text-brand-600 ring-1 ring-brand-300/25 focus:ring-brand-300"
        type="checkbox"
        id="${name}"
        name="${name}"
        <#if value>checked</#if>
      />
      <span class="text-gray-800">${label}</span>
      <#if required>
        <span class="text-red-600" aria-hidden="true">&#42;</span>
      </#if>
    </label>
  </div>
</#macro>