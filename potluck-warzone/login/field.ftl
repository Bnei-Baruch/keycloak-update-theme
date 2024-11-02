<#macro group name label error="" required=false>

<#--  INPUT_LABEL  -->
<div class="${properties.kcFormGroupClass}">
  <div class="${properties.kcFormGroupLabelClass} mb-2">
    <label for="${name}" class="${properties.kcFormGroupLabelClass}">
        <span class="text-gray-700">
          ${label}
        </span>
        <#if required>
          <span class="${properties.kcInputRequiredClass}" aria-hidden="true">&#42;</span>
        </#if>
    </label>
  </div>

  <#nested>

  <div id="input-error-client-${name}"></div>
  <#if error?has_content>
    <div class="${properties.kcFormHelperTextClass}" aria-live="polite">
      <div class="${properties.kcInputHelperTextClass}">
        <div
          class="${properties.kcInputHelperTextItemClass} ${properties.kcError}"
          id="input-error-${name}">
          <span class="${properties.kcInputErrorMessageClass}">
              ${error}
          </span>
        </div>
      </div>
    </div>
  </#if>
</div>

</#macro>

<#macro errorIcon error="">
  <#if error?has_content>
    <span class="${properties.kcFormControlUtilClass} text-red-600 flex">
        <span class="${properties.kcInputErrorIconStatusClass}">
          <i class="${properties.kcInputErrorIconClass}" aria-hidden="true"></i>
        </span>
    </span>
  </#if>
</#macro>

<#--  INPUT_TEXT  -->
<#macro input name label value="" required=false autocomplete="off" fieldName=name autofocus=false>
  <#assign error=kcSanitize(messagesPerField.get(fieldName))?no_esc>
  <@group name=name label=label error=error required=required>
    <span class="<#if error?has_content></#if>">
        <input class="px-4 py-2.5 bg-white text-gray-800 rounded-lg border border-gray-300 focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500 w-full" id="${name}" name="${name}" value="${value}" type="text" autocomplete="${autocomplete}" <#if autofocus>autofocus</#if> aria-invalid="<#if error?has_content>true</#if>"/>
    </span>
  </@group>
</#macro>

<#--  INPUT_PASSWORD  -->
<#macro password name label value="" required=false forgotPassword=false fieldName=name autocomplete="off" autofocus=false>
  <#assign error=kcSanitize(messagesPerField.get(fieldName))?no_esc>
  <@group name=name label=label error=error required=required>
    <div class="flex item-center gap-3 w-full">
      <div class="w-full">
        <span class="<#if error?has_content>${properties.kcError}</#if>">
          <input class="px-4 py-2.5 bg-white text-gray-800 rounded-lg border border-gray-300 focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500 w-full" id="${name}" name="${name}" value="${value}" type="password" autocomplete="${autocomplete}" <#if autofocus>autofocus</#if> aria-invalid="<#if error?has_content>true</#if>"/>
        </span>
      </div>
      <div class="${properties.kcInputGroupItemClass}">
        <button class="px-4 py-2.5 bg-white text-gray-800 rounded-lg border border-gray-300 focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500" type="button" aria-label="${msg('showPassword')}"
                aria-controls="${name}" data-password-toggle
                data-icon-show="fa-eye fas" data-icon-hide="fa-eye-slash fas"
                data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
            <i class="fa-eye fas" aria-hidden="true"></i>
        </button>
      </div>
    </div>
      <#if forgotPassword>
        <div class="${properties.kcFormHelperTextClass} mt-3 float-right" aria-live="polite">
            <div class="${properties.kcInputHelperTextClass}">
                <div class="${properties.kcInputHelperTextItemClass}">
                    <span class="${properties.kcInputHelperTextItemTextClass} text-gray-600 hover:text-purple-600 transition">
                        <a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                    </span>
                </div>
            </div>
        </div>
      </#if>
  </@group>
</#macro>

<#--  INPUT_CHECKBOX  -->
<#macro checkbox name label value=false required=false>
  <div>
    <label for="${name}">
      <input
        class="rounded mb-1 focus:outline-none outline-none border border-purple-400 text-purple-600 ring-1 ring-purple-300/25 focus:ring-purple-300"
        type="checkbox"
        id="${name}"
        name="${name}"
        <#if value>checked</#if>
      />
      <span class="text-gray-800">${label}</span>
      <#if required>
        <span class="${properties.kcCheckboxLabelRequiredClass}" aria-hidden="true">&#42;</span>
      </#if>
    </label>
  </div>
</#macro>