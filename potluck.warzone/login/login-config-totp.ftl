<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "password-commons.ftl" as passwordCommons>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>
<!-- template: login-config-totp.ftl -->
    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <ol id="kc-totp-settings" class="pf-v5-c-list pf-v5-u-mb-md text-gray-800 list-[square]">
            <li>
                <p>${msg("loginTotpStep1")}</p>

                <ul id="kc-totp-supported-apps" class="list-disc">
                    <#list totp.supportedApplications as app>
                        <li>${msg(app)}</li>
                    </#list>
                </ul>
            </li>

            <#if mode?? && mode = "manual">
                <li>
                    <p>${msg("loginTotpManualStep2")}</p>
                    <p><span id="kc-totp-secret-key" class="font-semibold">${totp.totpSecretEncoded}</span></p>
                    <p><a class="text-purple-500 hover:text-purple-600 transition font-semibold" href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                </li>
                <li>
                    <p>${msg("loginTotpManualStep3")}</p>
                    <p>
                    <ul>
                        <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                        <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                        <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                        <#if totp.policy.type = "totp">
                            <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                        <#elseif totp.policy.type = "hotp">
                            <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                        </#if>
                    </ul>
                    </p>
                </li>
            <#else>
                <li>
                    <p>${msg("loginTotpStep2")}</p>
                    <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                    <p><a class="text-purple-500 hover:text-purple-600 transition font-semibold" href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                </li>
            </#if>
            <li>
                <p>${msg("loginTotpStep3")}</p>
                <p>${msg("loginTotpStep3DeviceName")}</p>
            </li>
        </ol>

        <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post" novalidate="novalidate">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelClass!} mb-2">
                    <label class="pf-v5-c-form__label" for="form-vertical-name">
                        <span class="text-gray-700">${msg("authenticatorCode")}</span>&nbsp;<span class="pf-v5-c-form__label-required" aria-hidden="true">&#42;</span>
                    </label>
                </div>
                <div class="<#if messagesPerField.existsError('totp')>text-red-600</#if>">
                    <input type="text" required id="totp" name="totp" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                           dir="ltr"
                           class="px-4 py-2.5 bg-white text-gray-800 rounded-lg border border-gray-300 focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500 w-full"
                    />
                </div>
                <#if messagesPerField.existsError('totp')>
                    <div class="inline-flex item-center space-x-2 mt-1 text-sm">
                        <@field.errorIcon error=kcSanitize(messagesPerField.get('totp'))?no_esc/>
                        <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!} text-gray-700" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                        </span>
                    </div>
                </#if>
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            </div>
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelClass!} mb-2">
                    <label class="pf-v5-c-form__label" for="form-vertical-name">
                        <span class="text-gray-700">${msg("loginTotpDeviceName")}</span><#if totp.otpCredentials?size gte 1>&nbsp;<span class="pf-v5-c-form__label-required" aria-hidden="true">&#42;</span></#if>
                    </label>
                </div>

                <div class="">
                    <input type="text" id="userLabel" name="userLabel" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>"
                           dir="ltr"
                           class="px-4 py-2.5 bg-white text-gray-800 rounded-lg border border-gray-300 focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500 w-full"
                    />

                </div>
                <#if messagesPerField.existsError('userLabel')>
                    <div class="inline-flex item-center space-x-2 mt-1 text-sm">
                        <@field.errorIcon error=kcSanitize(messagesPerField.get('userLabel'))?no_esc/>
                        <span id="input-error-otp-label" class="${properties.kcInputErrorMessageClass!} text-gray-700" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                        </span>
                    </div>
                </#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <@passwordCommons.logoutOtherSessions/>
            </div>

            <div class="pf-v5-c-form__group pf-m-action">
                <div class="pf-v5-c-form__actions float-right">
                    <#if isAppInitiatedAction??>
                        <button type="submit"
                            class="w-max py-2.5 px-4 rounded-lg border-2 border-purple-400 text-center text-purple-600 w-full"
                            id="cancelTOTPBtn" name="cancel-aia" value="true" />${msg("doCancel")}
                        </button>
                        <input type="submit"
                            class="w-max px-4 py-2.5 bg-purple-600 hover:bg-purple-500 text-white w-full rounded-lg"
                            id="saveTOTPBtn" value="${msg("doSubmit")}"
                        />
                    <#else>
                        <input type="submit"
                            class="px-4 py-2.5 bg-purple-600 hover:bg-purple-500 text-white w-full rounded-lg"
                            id="saveTOTPBtn" value="${msg("doSubmit")}"
                        />
                    </#if>
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
