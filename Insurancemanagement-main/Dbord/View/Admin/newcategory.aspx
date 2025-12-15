<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="newcategory.aspx.cs"
    Inherits="Dbord.View.Admin.newcategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
    
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    .icon-btn{
        display:inline-flex;align-items:center;justify-content:center;
        width:32px;height:32px;border-radius:4px;
        font-size:14px;margin-right:4px;cursor:pointer;
    }
    .icon-success{background:#28a745;color:#fff}
    .icon-cancel{background:#6c757d;color:#fff}
    .icon-btn:hover{opacity:.85}

    .grid-footer-pager{
        padding:12px 0;text-align:center
    }
    .grid-footer-pager a,.grid-footer-pager span{
        display:inline-block;min-width:34px;
        padding:6px 10px;margin:0 3px;
        border:1px solid #dee2e6;border-radius:4px;
        color:#0d6efd;text-decoration:none
    }
    .grid-footer-pager span{
        background:#0d6efd;color:#fff;font-weight:600
    }
</style>

<br />
<div class="card">
    <div class="card-header alert alert-danger">Add new Category</div>
    <div class="card-body">
        <div class="row">
            <div class="col-sm-6">
                <asp:TextBox ID="txtcategoryname" runat="server"
                    CssClass="form-control" Placeholder="Category Name" />
                            <asp:RequiredFieldValidator
ID="rfvCompany"
runat="server"
ControlToValidate="txtcategoryname"
ErrorMessage="Company Name is required"
Display="Dynamic"
CssClass="text-danger"
ValidationGroup="category"
SetFocusOnError="true" />
            </div>
            <div class="col-sm-6">
                <asp:Button ID="btnSubmit" runat="server"
                    CssClass="btn btn-success" Text="Save" OnClick="btnSubmit_Click" ValidationGroup="category"  />
                <asp:Button ID="btnClear" runat="server"
                    CssClass="btn btn-warning ml-2" Text="Clear" />
            </div>
        </div>
    </div>
</div>


<div class="card mt-3">
    <div class="card-header alert alert-success">Category List</div>
    <div class="card-body">
        <asp:ScriptManager 
ID="ScriptManager1" 
runat="server" />
        <asp:UpdatePanel ID="upGrid" runat="server">
            <ContentTemplate>

                <asp:GridView ID="gvcate" runat="server"
                    AutoGenerateColumns="false"
                    DataKeyNames="c_id"
                    AllowPaging="true"
                    PageSize="5"
                    PagerSettings-Position="Bottom"
                    CssClass="table table-bordered table-striped"
                    OnPageIndexChanging="gvcate_PageIndexChanging"
                    OnRowEditing="gvcate_RowEditing"
                    OnRowUpdating="gvcate_RowUpdating"
                    OnRowCancelingEdit="gvcate_RowCancelingEdit"
                    OnRowDeleting="gvcate_RowDeleting">

                    <PagerSettings Mode="NumericFirstLast"
                        FirstPageText="First"
                        LastPageText="Last" />

                    <PagerStyle CssClass="grid-footer-pager" />

                    <Columns>

                     
                        <asp:TemplateField HeaderText="S.No">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 + (gvcate.PageIndex * gvcate.PageSize) %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="c_id" HeaderText="ID" ReadOnly="true"/>

                        <asp:TemplateField HeaderText="Category Name">
                            <ItemTemplate><%# Eval("CategoryName") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCategoryName" runat="server"
                                    CssClass="form-control"
                                    Text='<%# Bind("CategoryName") %>' />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton runat="server"
                                    CommandName="Edit"
                                    CssClass="btn btn-sm btn-warning">
                                    <i class="fa fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton runat="server"
                                    CommandName="Delete"
                                    CssClass="btn btn-sm btn-danger"
                                    OnClientClick="return confirm('Delete?');">
                                    <i class="fa fa-trash"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton runat="server"
                                    CommandName="Update"
                                    CssClass="icon-btn icon-success">
                                    <i class="fa fa-check"></i>
                                </asp:LinkButton>
                                <asp:LinkButton runat="server"
                                    CommandName="Cancel"
                                    CssClass="icon-btn icon-cancel">
                                    <i class="fa fa-times"></i>
                                </asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</div>

</asp:Content>
