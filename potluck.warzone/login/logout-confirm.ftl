<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>

<@layout.registrationLayout pageId="logout-confirm" displayMessage=!messagesPerField.existsError('logout'); section>
  <#if section == "header">
    ${msg("logoutConfirmTitle")!"Logging out"}
  <#elseif section == "form">
    <form id="kc-logout-form" action="${url.logoutConfirmAction}" method="post" novalidate="novalidate">
      <p class="mb-4">${msg("logoutConfirmHeader")!"Do you want to log out?"}</p>
      <@buttons.actionGroup>
        <@buttons.button label="doLogout" id="logout" class=[] />
        <@buttons.buttonOutline label="backToApplication" id="back-to-app" name="cancel" class=[] />
      </@buttons.actionGroup>
    </form>
  </#if>
</@layout.registrationLayout>

