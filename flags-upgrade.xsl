<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rw="http://www.rapidweb.tools/rw" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://creativecommons.org/ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape">

	<xsl:output method="xml" indent="yes" encoding="utf-8"/>

	<xsl:template match="rw:collection">
		<rw:collection>
			<xsl:apply-templates select="@* | * | text()"/>
		</rw:collection>	
	</xsl:template>

	<xsl:template match="rw:template">
		<rw:template>
			<xsl:apply-templates select="@* | * | text()"/>
		</rw:template>	
	</xsl:template>

	<xsl:template match="svg:svg">
	
		<xsl:copy>
			<xsl:apply-templates select="@*"/>

			<xsl:variable name="ratio" select="number(@width) div number(@height)"/>

			<xsl:variable name="height" select="24"/>

			<xsl:attribute name="width">
		<!--		<xsl:text>60</xsl:text>-->
				<xsl:value-of select="number($height) * $ratio"/>
			</xsl:attribute>
			<xsl:attribute name="height">
				<xsl:value-of select="$height"/>
			</xsl:attribute>
			
			<xsl:if test="not(@viewBox)">
				<xsl:attribute name="viewBox">
					<xsl:text>0 0 </xsl:text>
					<xsl:value-of select="@width"/>
				<!--	<xsl:value-of select="@height * 2"/>-->
					<xsl:text> </xsl:text>	
					<xsl:value-of select="@height"/>					
				</xsl:attribute>
			</xsl:if>
			
			<xsl:apply-templates select="* | text()"/>		
		</xsl:copy>
	
	</xsl:template>
	
	<xsl:template match="*">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="* | @* | text()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*">
		<xsl:attribute name="{name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="text()">
		<xsl:value-of select="."/>
	</xsl:template>

</xsl:stylesheet>
