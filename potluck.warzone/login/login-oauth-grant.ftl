<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>
<@layout.registrationLayout bodyClass="oauth"; section>
    <#if section = "header">
        <#if client.attributes.logoUri??>
            <img src="${client.attributes.logoUri}"/>
        </#if>
        <p>
        <#if client.name?has_content>
            ${msg("oauthGrantTitle",advancedMsg(client.name))}
        <#else>
            ${msg("oauthGrantTitle",client.clientId)}
        </#if>
        </p>
    <#elseif section = "form">
        <div id="kc-oauth" class="w-full">
            <h3 class="mb-3">${msg("oauthGrantRequest")}</h3>
            <ul class="w-full flex-wrap flex items-center gap-3">
                <#if oauth.clientScopesRequested??>
                    <#list oauth.clientScopesRequested as clientScope>
                        <li >
                            <div class="py-0.5 px-2 border border-purple-400 text-purple-700 bg-purple-50 rounded-md text-sm">
                                <#if !clientScope.dynamicScopeParameter??>
                                        ${advancedMsg(clientScope.consentScreenText)}
                                    <#else>
                                        ${advancedMsg(clientScope.consentScreenText)}: <b>${clientScope.dynamicScopeParameter}</b>
                                </#if>
                            </div>
                        </li>
                    </#list>
                </#if>
            </ul>
            <#if client.attributes.policyUri?? || client.attributes.tosUri??>
                <h3 class="my-4">
                    <#if client.name?has_content>
                        ${msg("oauthGrantInformation",advancedMsg(client.name))}
                    <#else>
                        ${msg("oauthGrantInformation",client.clientId)}
                    </#if>

                </h3>
                <p>
                    <#if client.attributes.tosUri?? || client.attributes.policyUri??>
                        ${msg("oauthGrantReview")}
                    </#if>
                    <#if client.attributes.tosUri??>
                        <a class="text-purple-600 capitalize" href="${client.attributes.tosUri}" target="_blank">${msg("oauthGrantTos")}</a>
                    </#if>
                    <#if client.attributes.tosUri?? && client.attributes.policyUri??>
                        &
                    </#if>
                    <#if client.attributes.policyUri??>
                        <a class="text-purple-600 capitalize" href="${client.attributes.policyUri}" target="_blank">${msg("oauthGrantPolicy")}</a>
                    </#if>
                </p>
            </#if>

            <form class="${properties.kcFormClass} ${properties.kcMarginTopClass!}" action="${url.oauthAction}" method="POST">
                <input type="hidden" name="code" value="${oauth.code}">
                <@buttons.actionGroup>
                    <@buttons.buttonOutline id="kc-cancel" name="cancel" label="doNo"/>
                    <@buttons.button id="kc-login" name="accept" label="doYes"/>
                </@buttons.actionGroup>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>
