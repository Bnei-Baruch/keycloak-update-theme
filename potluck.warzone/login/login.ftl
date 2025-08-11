<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>
<#import "social-providers.ftl" as identityProviders>
<@layout.registrationLayout pageId="login" displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>

<!-- template: login.ftl -->

    <#if section == "header">
        ${msg("loginAccountTitle")}
    <#elseif section == "form">
        <div id="kc-form" class="w-full">
          <div id="kc-form-wrapper" class="w-full">
            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" novalidate="novalidate">
                    <#if !usernameHidden??>
                        <#assign label>
                            <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                        </#assign>
                        <@field.input name="username" label=label autofocus=true autocomplete="username" value=login.username!'' />
                    </#if>

                    <div class="mt-3">
                        <@field.password name="password" label=msg("password") forgotPassword=realm.resetPasswordAllowed autofocus=usernameHidden?? autocomplete="current-password" />
                    </div>

                    <#if realm.rememberMe && !usernameHidden??>
                        <div class="mt-4">
                            <@field.checkbox name="rememberMe" label=msg("rememberMe") value=login.rememberMe?? />
                        </div>
                    </#if>

                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <@buttons.loginButton />
                </form>
                
                <#if realm.registrationAllowed && !registrationDisabled?? && social.providers?? && social.providers?has_content>
                    <div class="mt-6 text-center">
                        <span class="text-base font-semibold text-gray-600 <#if locale.currentLanguageTag?starts_with("he") || locale.currentLanguageTag?starts_with("ar")>rtl-text</#if>">${msg("noAccount")} <a href="${url.registrationUrl}" class="text-brand-600 font-bold text-base hover:underline">${msg("doRegister")}</a></span>
                    </div>
                </#if>
            </#if>
            </div>
        </div>
    <#elseif section == "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled?? && (!social.providers?? || !social.providers?has_content)>
            <div id="kc-registration-container" class="text-gray-600 text-center">
                <div id="kc-registration">
                    <div class="text-lg font-semibold <#if locale.currentLanguageTag?starts_with("he") || locale.currentLanguageTag?starts_with("ar")>rtl-text</#if>">${msg("noAccount")}</div>
                    <div class="mt-2">
                        <a href="${url.registrationUrl}" class="text-brand-600 font-bold text-lg">Register here</a>
                    </div>
                </div>
            </div>
        </#if>
    <#elseif section == "socialProviders" >
        <#if realm.password && social.providers?? && social.providers?has_content>
            <@identityProviders.show social=social/>
        </#if>
    </#if>
</@layout.registrationLayout>
