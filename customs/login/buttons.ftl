<#macro actionGroup>
  <div class="${properties.kcFormGroupClass}">
    <div class="${properties.kcFormActionGroupClass}">
      <#nested>
    </div>
  </div>
</#macro>

<#macro button label id="" name="" class=[""]>
  <button class="px-4 py-2.5 bg-purple-600 hover:bg-purple-500 text-white w-full rounded-lg" name="${name}" id="${id}" type="submit">${msg(label)}</button>
</#macro>

<#macro buttonLink href label id="" class=[""]>
  <#--  <a id="${id}" href="${href}" class="<#list class as c>${properties[c]} </#list>">${kcSanitize(msg(label))?no_esc}</a>  -->
  <a id="${id}" href="${href}" class="py-2.5 px-4 rounded-lg border-2 border-purple-400 text-center text-purple-600 w-full">${kcSanitize(msg(label))?no_esc}</a>
</#macro>

<#macro loginButton>
  <@buttons.actionGroup>
    <@buttons.button id="kc-login" name="login" label="doLogIn" class=["kcButtonPrimaryClass", "kcButtonBlockClass"] />
  </@buttons.actionGroup>
</#macro>