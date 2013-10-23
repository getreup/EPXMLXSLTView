<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <body style="margin: 0px; padding: 0px; height: 100%;">
                <xsl:variable name="DataObject" select="/DataObject"/>
                <xsl:for-each select="/DataObjects/DataObject">
                    <p><xsl:value-of select="@title"/></p>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

