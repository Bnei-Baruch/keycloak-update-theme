<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>

<@layout.registrationLayout pageId="email-sent" displayMessage=false; section>
  <#if section == "header">
    ${msg("emailSentTitle")!"Check your email"}
  <#elseif section == "form">
    <div id="kc-info-message" class="space-y-4">
      <p class="mb-3">
        ${message.summary! "If an account exists for the address you entered, we've sent a link to reset your password."}
      </p>

      <ul class="list-disc pl-5 text-sm text-gray-600">
        <li>${msg("emailCheckSpam")!"Check your inbox and spam folder."}</li>
        <li>${msg("emailLinkValidity")!"The link is valid for a limited time."}</li>
      </ul>

      <div class="mt-6">
        <@buttons.buttonLink href="${url.loginUrl}" label="backToLogin" class=[]/>
      </div>
    </div>
  </#if>
</@layout.registrationLayout>
