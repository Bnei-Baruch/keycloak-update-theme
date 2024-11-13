<#macro actionGroup>
  <div class="flex flex-wrap item-center justify-end gap-4 mt-6">
    <#nested>
  </div>
</#macro>

<#macro button label id="" name="" class=[""]>
  <button class="px-8 py-2.5 transition bg-purple-600 hover:bg-purple-500 text-white w-max float-right rounded-lg" name="${name}" id="${id}" type="submit">${msg(label)}</button>
</#macro>

<#macro buttonOutline label id="" name="" class=[""]>
  <button class="px-8 py-2.5 transition rounded-lg border-2 hover:bg-purple-50 border-purple-400 text-center text-purple-600 w-max float-right" name="${name}" id="${id}" type="submit">${msg(label)}</button>
</#macro>

<#macro buttonLink href label id="" class=[""]>
  <a id="${id}" href="${href}" class="px-8 py-2.5 transition hover:bg-purple-50 rounded-lg border-2 border-purple-400 text-center text-purple-600 w-max float-right">${kcSanitize(msg(label))?no_esc}</a>
</#macro>

<#macro loginButton>
  <@buttons.actionGroup>
    <@buttons.button id="kc-login" name="login" label="doLogIn" class=[] />
  </@buttons.actionGroup>
</#macro>