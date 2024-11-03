<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>
<@layout.registrationLayout displayMessage=false; section>
    <#if section="header">
        ${kcSanitize(msg("errorTitle"))?no_esc}
        <#elseif section="form">
            <div id="kc-error-message">
                <p class="instruction text-gray-800 mb-5">
                    ${kcSanitize(message.summary)?no_esc}
                </p>
                <#if skipLink??>
                    <#else>
                        <#if client?? && client.baseUrl?has_content>
                            <@buttons.buttonLink href=client.baseUrl id="backToApplication" label="backToApplication" class=[] />
                        </#if>
                </#if>
            </div>
    </#if>
</@layout.registrationLayout>