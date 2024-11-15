<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>

<@layout.registrationLayout displayMessage=false; section>
<!-- template: terms.ftl -->

    <#if section = "header">
        ${msg("termsTitle")}
    <#elseif section = "form">
    <div>
        ${kcSanitize(msg("termsText", client.name))?no_esc}
    </div>
    <form action="${url.loginAction}" method="POST">
        <@buttons.actionGroup>
            <@buttons.buttonOutline name="cancel" id="kc-decline" label="doDecline"/>
            <@buttons.button name="accept" id="kc-accept" label="doAccept"/>
        </@buttons.actionGroup>
    </form>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
