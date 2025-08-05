<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>

<@layout.registrationLayout pageId="reset-password" displayInfo=false displayMessage=!messagesPerField.existsError('username'); section>
    
    <#if section == "header">
        ${msg("emailForgotTitle")}
    
    <#elseif section == "form">
        <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
            <#assign label>
                <#if !realm.loginWithEmailAllowed>
                    ${msg("username")}
                <#elseif !realm.registrationEmailAsUsername>
                    ${msg("usernameOrEmail")}
                <#else>
                    ${msg("email")}
                </#if>
            </#assign>

            <@field.input name="username" label=label value=auth.attemptedUsername!'' autofocus=true />

            <#--text under email filed-->
            <div class="instruction-text" style="margin-top: 20px;">
                <#if realm.duplicateEmailsAllowed>
                    <p class="text-gray-600">${msg("emailInstructionUsername")}</p>
                <#else>
                    <p class="text-gray-600">${msg("emailInstruction")}</p>
                </#if>
            </div>

            <div style="margin-top: 30px;">
            <@buttons.actionGroup>
                <@buttons.buttonLink href=url.loginUrl label="backToLogin" class=[]/>
                <@buttons.button id="kc-form-buttons" label="doSubmit" class=[]/>
            </@buttons.actionGroup>
            </div>
        </form>
    </#if>

</@layout.registrationLayout>
