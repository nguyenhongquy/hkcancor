<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="mysqldump/database">
  <html>
  <body>
    <xsl:for-each select="table_structure">
      <xsl:variable name="tableIndex" select="number(substring(@name, 2, 2))"/>
      <xsl:if test="$tableIndex &lt; 10 and $tableIndex &gt; 4 ">
        <xsl:variable name="tableName" select="@name"/>
        <h2><xsl:value-of select="@name" /></h2>
        <table border="1">
          <tr bgcolor="#9acd32">
               <xsl:for-each select="field">
                 <th><xsl:value-of select="@Field" /></th>
               </xsl:for-each>
          </tr>
          <xsl:for-each select="../table_data[@name=$tableName]/row">
          <tr>
            <xsl:for-each select="field">
              <td><xsl:value-of select="." /></td>
            </xsl:for-each>
          </tr>
          </xsl:for-each>
        </table>
        </xsl:if>
    </xsl:for-each>
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>

