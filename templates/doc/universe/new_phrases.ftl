<#-- 单词生词表 -->
<#import 'common.ftl' as common/>
<@common.contatiner>
	<@common.title common.new_phrases_title/>
    <w:tbl>
      <w:tblPr>
        <w:tblW w:w="0" w:type="auto"/>
        <w:tblBorders>
          <w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="${common.table_border_color}"/>
          <w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="${common.table_border_color}"/>
          <w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="${common.table_border_color}"/>
          <w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="${common.table_border_color}"/>
          <w:insideH w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="${common.table_border_color}"/>
          <w:insideV w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="${common.table_border_color}"/>
        </w:tblBorders>
        <w:tblLook w:val="04A0"/>
      </w:tblPr>
      <w:tblGrid>
        <w:gridCol w:w="5236"/>
      </w:tblGrid>
		<#-- @ftlvariable name="phrases" type="java.util.List" -->
      <#list phrases as phrase>
			<#-- @ftlvariable name="phrase" type="com.benzolamps.dict.bean.Phrase" -->
        <w:tr wsp:rsidR="00E602B2" wsp:rsidRPr="006C50AA" wsp:rsidTr="00E602B2">
          <w:trPr>
            <w:cantSplit/>
          </w:trPr>
          <w:tc>
            <w:tcPr>
              <w:tcW w:w="5236" w:type="dxa"/>
              <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
            </w:tcPr>
            <w:tbl>
              <w:tblPr>
                <w:tblW w:w="0" w:type="auto"/>
                <w:jc w:val="center"/>
                <w:tblLook w:val="04A0"/>
              </w:tblPr>
              <w:tblGrid>
                <w:gridCol w:w="2299"/>
                <w:gridCol w:w="2721"/>
              </w:tblGrid>
              <w:tr wsp:rsidR="00E602B2" wsp:rsidRPr="006C50AA" wsp:rsidTr="00C52ADE">
                <w:trPr>
                  <w:cantSplit/>
                  <w:jc w:val="center"/>
                </w:trPr>
                <w:tc>
                  <w:tcPr>
                    <w:tcW w:w="2299" w:type="dxa"/>
                    <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    <w:vAlign w:val="center" />
                  </w:tcPr>
                  <w:p wsp:rsidR="00E602B2" wsp:rsidRPr="006C50AA" wsp:rsidRDefault="00C52ADE" wsp:rsidP="00E602B2">
                    <w:pPr>
                      <w:spacing w:line="${common.line_height}" w:line-rule="auto"/>
                      <w:jc w:val="left"/>
                      <w:rPr>
                        <w:rFonts w:ascii="${common.en_font_family}" w:fareast="${common.cn_font_family}" w:h-ansi="${common.en_font_family}"/>
                        <wx:font wx:val="${common.en_font_family}"/>
                        <w:sz w:val="${common.font_size}"/>
                        <w:sz-cs w:val="${common.font_size}"/>
                      </w:rPr>
                    </w:pPr>
                    <w:r wsp:rsidRPr="006C50AA">
                      <w:rPr>
                        <w:rFonts w:ascii="${common.en_font_family}" w:fareast="${common.cn_font_family}" w:h-ansi="${common.en_font_family}"/>
                        <wx:font wx:val="${common.en_font_family}"/>
                        <w:sz w:val="${common.font_size}"/>
                        <w:sz-cs w:val="${common.font_size}"/>
                      </w:rPr>
                      <w:t>${phrase_index + 1}. </w:t>
                    </w:r>
                    <w:r wsp:rsidRPr="006C50AA">
                      <w:rPr>
                        <w:rFonts w:ascii="${common.en_font_family}" w:fareast="${common.cn_font_family}" w:h-ansi="${common.en_font_family}"/>
                        <wx:font wx:val="${common.en_font_family}"/>
                        <w:b />
                        <w:i />
                        <w:sz w:val="${common.font_size}"/>
                        <w:sz-cs w:val="${common.font_size}"/>
                      </w:rPr>
                      <w:t>${phrase.prototype}</w:t>
                    </w:r>
                  </w:p>
                </w:tc>
                <w:tc>
                  <w:tcPr>
                    <w:tcW w:w="2721" w:type="dxa"/>
                    <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    <w:vAlign w:val="center"/>
                  </w:tcPr>
                  <w:p wsp:rsidR="00E602B2" wsp:rsidRPr="006C50AA" wsp:rsidRDefault="00C52ADE" wsp:rsidP="00E602B2">
                    <w:pPr>
                      <w:jc w:val="right"/>
                      <w:rPr>
                        <w:rFonts w:ascii="${common.en_font_family}" w:fareast="${common.cn_font_family}" w:h-ansi="${common.en_font_family}"/>
                        <wx:font wx:val="${common.en_font_family}"/>
                        <w:sz w:val="${common.font_size}"/>
                        <w:sz-cs w:val="${common.font_size}"/>
                      </w:rPr>
                    </w:pPr>
                  </w:p>
                </w:tc>
              </w:tr>
              <w:tr wsp:rsidR="00C52ADE" wsp:rsidRPr="006C50AA" wsp:rsidTr="00554791">
                <w:trPr>
                  <w:cantSplit/>
                  <w:jc w:val="center"/>
                </w:trPr>
                <w:tc>
                  <w:tcPr>
                    <w:tcW w:w="2299" w:type="dxa"/>
                    <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                    <w:vAlign w:val="center"/>
                  </w:tcPr>
                  <#if common.definition_arranges_vertically>
										<@common.vertical_arrangement phrase.definition/>
									<#else>
										<@common.horizental_arrangement phrase.definition/>
									</#if>
                </w:tc>
                <w:tc>
                  <w:tcPr>
                    <w:tcW w:w="2721" w:type="dxa"/>
                  </w:tcPr>
                  <w:p wsp:rsidR="00C52ADE" wsp:rsidRPr="006C50AA" wsp:rsidRDefault="00C52ADE" wsp:rsidP="00E602B2">
                    <w:pPr>
                      <w:jc w:val="right"/>
                      <w:rPr>
                        <w:rFonts w:ascii="${common.en_font_family}" w:fareast="${common.en_font_family}" w:h-ansi="${common.en_font_family}"/>
                        <wx:font wx:val="${common.en_font_family}"/>
                        <w:sz w:val="${common.font_size}"/>
                        <w:sz-cs w:val="${common.font_size}"/>
                      </w:rPr>
                    </w:pPr>
                  </w:p>
                </w:tc>
              </w:tr>
              <#if common.insert_blank_line_between_words>
                <w:tr wsp:rsidR="00E602B2" wsp:rsidRPr="006C50AA" wsp:rsidTr="00E602B2">
                  <w:trPr>
                    <w:cantSplit/>
                    <w:jc w:val="center"/>
                  </w:trPr>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="5020" w:type="dxa"/>
                      <w:gridSpan w:val="3"/>
                      <w:shd w:val="clear" w:color="auto" w:fill="auto"/>
                      <w:vAlign w:val="center"/>
                    </w:tcPr>
                    <w:p wsp:rsidR="00E602B2" wsp:rsidRPr="006C50AA" wsp:rsidRDefault="00E602B2" wsp:rsidP="00E602B2">
                      <w:pPr>
                        <w:spacing w:line="${common.line_height}" w:line-rule="auto"/>
                        <w:jc w:val="left"/>
                        <w:rPr>
                          <w:rFonts w:ascii="${common.en_font_family}" w:fareast="${common.cn_font_family}" w:h-ansi="${common.en_font_family}" w:hint="fareast"/>
                          <wx:font wx:val="${common.en_font_family}"/>
                          <w:sz w:val="${common.font_size}"/>
                          <w:sz-cs w:val="${common.font_size}"/>
                        </w:rPr>
                      </w:pPr>
                    </w:p>
                  </w:tc>
                </w:tr>
							</#if>
            </w:tbl>
            <w:p wsp:rsidR="00E602B2" wsp:rsidRPr="00E602B2" wsp:rsidRDefault="00C52ADE" wsp:rsidP="00E602B2">
              <w:pPr>
                <w:spacing w:line="${common.line_height}" w:line-rule="auto"/>
                <w:jc w:val="left"/>
                <w:rPr>
                  <w:rFonts w:ascii="${common.en_font_family}" w:fareast="${common.cn_font_family}" w:h-ansi="${common.en_font_family}"/>
                  <wx:font wx:val="${common.en_font_family}"/>
                  <w:sz w:val="${common.font_size}"/>
                  <w:sz-cs w:val="${common.font_size}"/>
                </w:rPr>
              </w:pPr>
              <wx:allowEmptyCollapse/>
            </w:p>
          </w:tc>
        </w:tr>
			</#list>
    </w:tbl>
	<@common.line/>
</@common.contatiner>