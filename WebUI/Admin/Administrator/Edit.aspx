﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Master.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="ResearchManagementSystem.Admin.Administrator.Edit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderTop" runat="server">
    <link href="../css/Form.css" rel="stylesheet" />
    <script>

        $(function () {
            $("#RoleId").val('<%=Role.ID %>');
            $("#College").val('<%=Admin.College %>');

            var SelectChangeHandeler = function () {
                if ($('#RoleId').find("option:selected").text() == "校级管理员") {
                    $('#College').prepend("<option value='校级'>校级</option>");
                    $('#College').val("校级");
                    $('#College').attr("disabled", "disabled");
                } else if ($('#RoleId').find("option:selected").text() == "院级管理员") {
                    $("#College>option:eq(0)").remove();
                    $('#College').removeAttr("disabled");
                    $("#College").val('<%=Admin.College %>');
                }
            }

            if ($('#RoleId').find("option:selected").text() == "校级管理员") {
                $('#College').prepend("<option value='校级'>校级</option>");
                $('#College').val("校级");
                $('#College').attr("disabled", "disabled");
            } else if ($('#RoleId').find("option:selected").text() == "院级管理员") {
                $('#College').removeAttr("disabled");

            }


            $("#RoleId").change(SelectChangeHandeler);

           

            <%if(LoginRole.Name=="CollegeAdmin"){%>
          //  alert("testCollegeAdminInit");
            $('#College option').remove();
            $('#College').prepend("<option value='<%=LoginAdmin.College%>'><%=LoginAdmin.College%></option>");
            $('#College').attr("disabled", "disabled");
            <%}%>

        });

        function Submit() {

            var Id = $("#Id").val();
            var PasswordChecked = true;
            var Password = $("#Password").val();
            var ConfirmPassword = $("#ConfirmPassword").val();
            var UserId = $("#UserId").val();
            var RoleId = $("#RoleId").val();
            var Name = $("#Name").val();
            var JobId = $("#JobId").val();
            var College = $("#College").val();
            var Mail = $("#Mail").val();
            var Phone = $("#Phone").val();
            var Sex = $("#Sex").val();
            var Enable = $("#Enable").val();
            if (Password == "")
            {
                PasswordChecked = false;
            }
            if (PasswordChecked) {
                if (Password == "") {
                    alert("密码不为空");
                    return;
                }
                if (ConfirmPassword == "") {
                    alert("确认密码不为空");
                    return;
                }
                if (Password != ConfirmPassword) {
                    alert("两次输入密码不同");
                    return;
                }
            }
            if (Name == "") {
                alert("姓名不能为空");
                return;
            }
            if (JobId == "") {
                alert("工号不能为空");
                return;
            }
            if (College == "") {
                alert("学院不能为空");
                return;
            }
            if (Mail == "") {
                alert("邮箱不能为空");
                return;
            }
            if (Phone == "") {
                alert("电话不能为空");
                return;
            }

            var s = "";
            s = $.ajax({
                type: "POST",
                url: "AjaxAction.ashx",
                data: {
                    dowhat: "edit",
                    Id: Id,
                    PasswordChecked: PasswordChecked,
                    Password: Password,
                    UserId: UserId,
                    RoleId: RoleId,
                    Name: Name,
                    JobId: JobId,
                    College: College,
                    Mail: Mail,
                    Phone: Phone,
                    Sex: Sex,
                    Enable: Enable,
                },
                async: false
            }).responseText;
            if (s == "SUCCESS") {
                alert("修改成功");
                location.href = "Default.aspx";
            } else if (s == "FAILD") {
                alert("修改失败");
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeft" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderRight" runat="server">
    <div class="FormContent">
        <div class="FormTitle">
            <h3>修改管理员</h3>
        </div>

        <input type="hidden" id="Id" name="Id" value="<%=Admin.Id %>"/>
        <input type="hidden" id="UserId" name="UserId" value="<%=user.ID %>" />
       <div class="layout">
    <fieldset>
        <legend>修改用户：<%=user.Name %>的信息（* 为必填信息）</legend>
        <div class="Form">
            <div>
                     <label for="Password">新密码：</label><input type="password" id="Password" name="Password" /><label style="color:#ccc; padding-left:5px; display:inline;">不改密码无须输入</label>
                 </div>
                 <div>
                     <label for="ConfirmPassword">重新输入：</label><input type="password" id="ConfirmPassword" name="ConfirmPassword" />
                 </div>
            <div>
            <label for="RoleId">管理员级别：</label> 
        <%if(LoginRole.Name=="ScauAdmin"){ %>
            <select id="RoleId" name="RoleId">
                <%for(int i=0;i<Roles.Count;i++){ %>
                    <option value="<%=Roles[i].ID %>"><%=ConvertRoleName(Roles[i].Name) %></option>
                <%} %>
            </select>
        <%}else if(LoginRole.Name=="CollegeAdmin"){ %>
            <select id="RoleId" name="RoleId">
                <option value="<%=LoginRole.ID %>"><%=ConvertRoleName(LoginRole.Name) %></option>
            </select>
        <%} %>
            </div>
  
        <div>
          <label for="Name">姓名 * ：</label> <input type="text" id="Name" name="Name" value="<%=Admin.Name %>" />
        </div>
        <div>
          <label for="JobId">工号 * ：</label> <input type="text" id="JobId" name="JobId" value="<%=Admin.JobId %>" />
        </div>
        <div>
          <label for="College">学院 * ：</label> 
             <select id="College">
                            <option value="农学院">农学院</option>
                            <option value="资源环境学院">资源环境学院</option>
                            <option value="生命科学学院">生命科学学院</option>
                            <option value="经济管理学院">经济管理学院</option>
                            <option value="工程学院">工程学院</option>
                            <option value="动物科学学院">动物科学学院</option>
                            <option value="兽医学院">兽医学院</option>
                            <option value="园艺学院">园艺学院</option>
                            <option value="食品学院">食品学院</option>
                            <option value="林学院">林学院</option>
                            <option value="人文与法学学院">人文与法学学院</option>
                            <option value="理学院">理学院</option>
                            <option value="信息学院">信息学院</option>
                            <option value="艺术学院">艺术学院</option>
                            <option value="外国语学院">外国语学院</option>
                            <option value="水利与土木工程">水利与土木工程</option>
                            <option value="公共管理学院">公共管理学院</option>
                </select>
        </div>
        <div>
          <label for="Mail">邮箱 * ：</label> <input type="text" id="Mail" name="Mail" value="<%=Admin.Mail %>"/>
        </div>
        <div>
          <label for="Phone">电话 * ：</label> <input type="text" id="Phone" name="Phone" value="<%=Admin.Phone %>"/>
        </div>
        <div>
          <label for="Sex">性别：</label> <select id="Sex" name="Sex">
           <%if(Admin.Sex=="男") {%>
            <option value="男">
              男
            </option>
            <option value="女">
              女
            </option>
             <%} else{%>
             <option value="女">
              女
            </option>
            <option value="男">
              男
            </option>
             <%} %>
          </select>
           </div> 
            <div>
          <label for="Enable">启用:</label> <select id="Enable" name="Enable">
            <option value="false">
              否
            </option>
            <option value="true">
              是
            </option>
          </select>
        </div>
            <div><input type="button" class="lxcButton" value="提交" onclick="Submit()" /></div>
        </div>
    </fieldset>

       </div>
    </div>


    
   
</asp:Content>
