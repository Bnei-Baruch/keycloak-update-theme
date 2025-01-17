<#macro emailLayout>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
        <title>${realmName} Account</title>
        <!--[if mso]><style type="text/css">body, table, td, a { font-family: 'Roboto', sans-serif !important; }</style><![endif]-->
    </head>

    <body style="font-family: 'Roboto', sans-serif; margin: 0px; padding: 0px; background-color: #f9f9f9;">
        <table role="presentation" style="width: 100%; border-collapse: collapse; border: 0px; border-spacing: 0px; font-family: 'Roboto', sans-serif;">
            <tbody>
                <tr>
                    <td align="center" style="background-size: cover;background-repeat:no-repeat;background-position:top center; padding: 50px 10px;">
                        <table role="presentation" style="max-width: 600px; border-collapse: separate; border: 0px; border-spacing: 0px; text-align: left;">
                            <tbody>
                                <tr>
                                    <td style="background-color: white; border-radius: 10px; padding: 20px; border: 1.5px solid #ECECEC;box-shadow: 0 0px 25px rgba(44, 44, 44, 0.1);">
                                        <div style="text-align: left;">
                                            <div style="padding-bottom: 25px;">
                                                <img src="https://res.cloudinary.com/ekosutrisno/image/upload/v1623832497/Libox/maskable_icon_f3zasu.png" alt="Company Logo" style="width: 56px; border-radius: 100%;">
                                            </div>
                                        </div>
                                        <div>
                                            <div style="color: rgb(0, 0, 0); text-align: left;">
                                                <h1 style="margin: 1rem 0; font-size: 16px;">${realmName} Account</h1>
                                                <p>Hello,</p>
                                                
                                                <#nested>

                                                <p style="padding-bottom: 8px; margin-top: 10px; font-size: 14px; line-height: 120%;">
                                                    Thank you for choosing ${realmName}!
                                                </p>
                                                
                                                <p style="padding-bottom: 8px; font-size: 12px;">Best regards,<br>The ${realmName} Team</p>
                                            </div>
                                        </div>
                                        <div style="padding-top: 5px; color: rgb(153, 153, 153); text-align: center;">
                                            <div style="color: #999999;">
                                                <p style="font-family: 'Roboto', sans-serif; vertical-align: top; font-size: 12px; text-align: left; line-height: 125%;" valign="top" align="center">
                                                    <span style="text-align: center;">This email was sent by ${realmName}.</span>
                                                    <span style="text-align: center;">${realmName} is licensed and monitored by the relevant authorized authorities.</span>
                                                </p>
                                                <p style="font-family: 'Roboto', sans-serif; vertical-align: top; font-size: 12px; text-align: left; line-height: 125%;" valign="top" align="center">
                                                    <span style="text-align: center;">If you have any questions or concerns, please contact us at support@email.com.</span>
                                                </p>
                                            </div>
                                            <p class="content-block" style="font-family: 'Roboto', sans-serif; vertical-align: top; padding-bottom: 10px; color: #999999; font-size: 12px; text-align: left;" valign="top" align="center">
                                                <span class="apple-link" style="color: #999999; font-size: 12px; text-align: center;">${realmName} <br> Ashta Tower 21st Floor, Unit I, District 8,<br> SCBD Lot 28, Jl. Jend. Sudirman Kav. 54–55<br>Jakarta 12190</span>
                                            </p>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
</#macro>
