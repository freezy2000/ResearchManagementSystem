﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Master.Master" AutoEventWireup="true" CodeBehind="RecommendInfo.aspx.cs" Inherits="ResearchManagementSystem.Web.ProjectInfo.RecommendInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../css/styles/JForm.css" rel="stylesheet" />
     <link href="../../css/leftrightside.css" rel="stylesheet" />
    <link href="../../css/projectinfo.css" rel="stylesheet" />
    <script src="../../js/scripts/JForm.js"></script>
    <script>

        $(function () {
            <% if (CupModellist[0].Statu == "提交" || isDeadLine(Match.DeclarantDeadLine))
               {   %>
            var inputs = $('input');
            var selects = $('select');
            var textareas = $('textarea');
            $.each(inputs, function (i, elem) {
                $(elem).attr("disabled", "disabled");
            });
            $.each(selects, function (i, elem) {
                $(elem).attr("disabled", "disabled");
            });
            $.each(textareas, function (i, elem) {
                $(elem).attr("disabled", "disabled");
            });
            <%}%>
            var i = 1;
            
            $("#form0").jFormInit({
                triggerTargetId: "SubmitAll" //负责触发检查表单的默认按钮
            });
            $('.FormDelete').bind("click", function () {
                $(this).parent().remove();
            });


            $('#SubmitAll').bind("click", function () {
                var forms = $("form");
                var data = [];
                var flag = "AllFormIsOk";

                if (forms.length <= 0) {
                    alert("无推荐人无法保存！");
                    return;
                }

                $.each(forms, function (i, elem) {
                    if (!($(elem).jFormIsOk())) {
                        flag = "OneFormHasFalse";
                    } 
                });

                if (flag == "OneFormHasFalse") {
                    return;
                }
                $.each(forms, function (i, elem) {
                    data.push($(elem).serialize());
                });

                var s = "";
                s = $.ajax({
                    type: "POST",
                    url: "AjaxAction.ashx",
                    data: {
                        dowhat: "RecommendInfoCreate",
                        formsData: data,
                        ProjectID: '<%=ProjectID %>',
                    },
                    async: false
                }).responseText;
                if (s == "success") {
                    alert("操作成功！");
                    window.location.href = "../CupInfoEdit/RecommendInfo.aspx?ProjectID=<%=ProjectID %>";
                } else {
                    alert("操作失败！");
                }
            });


            $('#Add').bind("click", function () {
                var formHtml = '<form id="form'+ (i++)+ '" class="JForm"><div class="layout">'
                    +'<div><label for="Name">姓名：</label><input type="text" name="Name"  /><label class="Remark" for="Name">必须实名</label></div><div><label for="Sex">性别：</label><select name="Sex" class="InputSelect"><option value="男">男</option><option value="女">女</option></select></div>'
                    + '<div><label for="Age">年龄：</label><input type="text" name="Age" jformtype="number"/></div><div><label for="Title">职称：</label><input type="text" name="Title"/><label class="Remark" for="Title">如：教授</label></div>'
                    +'<div><label for="WorkUnits">工作单位：</label><input type="text" name="WorkUnits"  /><label class="Remark" for="WorkUnits">如：华南农业大学食品学院</label></div><div><label for="Address">通讯地址：</label><input type="text" name="Address"/><label class="Remark" for="Address">请填写学校住宿地址</label></div>'
                    + '<div><label for="PostalCode">邮政编码：</label><input type="text" name="PostalCode" jformtype="postalcode" /><label class="Remark" for="PostalCode">如：100191</label></div><div><label for="Phone">单位电话：</label><input type="text" name="Phone" jformtype="mobile" /><label class="Remark" for="Phone">11位或8位</label></div><div><label for="HomePhone">住宅电话：</label><input type="text" name="HomePhone" jformtype="homephone"/><label class="Remark" for="HomePhone">8位</label></div>'
                    +'<div><label for="Elaborate" class="Textlabel">请对申报者申报情况的真实性作出阐述：</label><textarea name="Elaborate" class="text"></textarea><label class="TextlabelRemark" for="Elaborate">250字以内</label></div>            <div><label for="Evaluate" class="Textlabel">请对作品的意义、技术水平、适用范围及推广前景作出评价：</label><textarea name="Evaluate" class="text"></textarea><label class="TextlabelRemark" for="Evaluate">160字以内</label></div><div><label for="Remark" class="Textlabel">其他说明：</label><textarea name="Remark" class="text"></textarea><label class="TextlabelRemark" for="Remark">90字以内,没有就填无</label></div>'
                    + '</div><input type="button" class="FormDelete" style="width:100px; height:30px; margin-left:335px; margin-bottom:20px;" value="删除团队成员"/>'
                    + '</form>';
                var forms = $("form");
                if (forms.length > 2) {
                    alert("团队成员不得超过3人！");
                    return;
                }
                $('#form' + (i - 1)).jFormInit({
                    triggerTargetId: "SubmitAll" //负责触发检查表单的默认按钮
                });
                
                $('.fButton').before(formHtml);
                $('.FormDelete').bind("click", function () {
                    $(this).parent().remove();
                });
            });


        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="leftside">
       <div class="ProjectStatu">当前作品状态</div>
        <label style="margin:15px; color:#f00;"><%=CupModellist[0].Statu %></label>    
        <h3 style="margin:10px; " class="ProjectInfo">项目信息填写</h3>

       <ul>
            <li><a href="DeclarantInfo.aspx?ProjectID=<%=ProjectID %>">申报人信息</a></li>
           <li><a href="TeamMemberInfo.aspx?ProjectID=<%=ProjectID %>">团队成员信息</a></li>
           <li><a href="WorkInfo.aspx?ProjectID=<%=ProjectID %>">作品信息</a></li>
           <li><a href="RecommendInfo.aspx?ProjectID=<%=ProjectID %>">推荐人信息</a></li>
           <li><a href="UploadPaper.aspx?ProjectID=<%=ProjectID %>">上传论文文档</a></li>
           <li><a href="Remark.aspx?ProjectID=<%=ProjectID %>">备注</a></li>
       </ul>




    </div>


    <div id="rightside">
       <div class="TitleHead">
            <a class="Picture" href="javascript:history.back(-1)"><img src="../../img/arrow-left.png" " /></a>
            <h2 class="Title">推荐人信息</h2>
            <hr />
            <br />
        </div>

        <form id="form0" class="JForm">
        <div class="layout">
            <div class="JFormDiv">
                <label for="Name">姓名：</label>
                <input type="text" name="Name"  />
                <label class="Remark" for="Name">必须实名</label>
            </div>

            <div class="JFormDiv">
                <label for="Sex">性别：</label>
                <select name="Sex" class="InputSelect">
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>

            <div class="JFormDiv">
                <label for="Age">年龄：</label>
                <input type="text" name="Age" jformtype="number" />
            </div>

             <div class="JFormDiv">
                <label for="Title">职称：</label>
                <input type="text" name="Title"/>
                <label class="Remark" for="Title">如：教授</label>
            </div>

            <div class="JFormDiv">
                <label for="WorkUnits">工作单位：</label>
                <input type="text" name="WorkUnits"  />
                <label class="Remark" for="WorkUnits">如：华南农业大学食品学院</label>
            </div>

            <div class="JFormDiv">
                <label for="Address">通讯地址：</label>
                <input type="text" name="Address"/>
                <label class="Remark" for="Address">请填写学校住宿地址</label>
            </div>


            <div class="JFormDiv">
                <label for="PostalCode">邮政编码：</label>
                <input type="text" name="PostalCode" jformtype="postalcode" />
                <label class="Remark" for="PostalCode">如：100191</label>
            </div>

            <div class="JFormDiv">
                <label for="Phone">单位电话：</label>
                <input type="text" name="Phone" jformtype="mobile" />
                <label class="Remark" for="Phone">11位</label>
            </div>

            <div class="JFormDiv">
                <label for="HomePhone">住宅电话：</label>
                <input type="text" name="HomePhone" jformtype="homephone"/>
                <label class="Remark" for="HomePhone">8位</label>
            </div>


    
                <div class="JFormDiv"> 
                    <label for="Elaborate" class="Textlabel">请对申报者申报情况的真实性作出阐述：</label>
                    <textarea name="Elaborate" class="text"></textarea>
                    <label class="TextlabelRemark" for="Elaborate">250字以内</label>

                </div>
               
   

                <div class="JFormDiv">
                    <label for="Evaluate" class="Textlabel">请对作品的意义、技术水平、适用范围及推广前景作出评价：</label>
                    <textarea name="Evaluate" class="text"></textarea>
                    <label class="TextlabelRemark" for="Evaluate">160字以内</label>
                </div>
                
     

            <div class="JFormDiv">
                <label for="Remark" class="Textlabel">其他说明：</label>
                <textarea name="Remark" class="text"></textarea>
                <label class="TextlabelRemark" for="Remark">90字以内,没有就填无</label>
            </div>

        </div>
        <input type="button" class="FormDelete" style="width:100px; height:30px; margin-top:20px; margin-left:335px; margin-bottom:20px;" value="删除成员"/>
         </form>

        <div class="fButton" >
            <hr />
            <br />
            <input type="button" id="SubmitAll" value="保存" class="lxcButton" style="width:70px; height:25px; margin-left:335px;" />
            <input type="button" id="Add" value="增加" class="lxcButton" style="width:70px; height:25px; margin-left:20px;" />
            <label style="color:#CCC; text-align:left;">最多3个</label>
            
        </div>


    </div>

</asp:Content>
