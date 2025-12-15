<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="showdata.aspx.cs" Inherits="Dbord.View.Admin.showdata" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        .table th {
            background-color: #2d5f72;
            color: white;
            text-align: center;
            padding: 8px;
            word-wrap: break-word;
        }
        .table td {
            padding: 8px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            word-wrap: break-word;
            white-space: normal;
        }
        .table td.actions {
            white-space: nowrap;
            word-wrap: normal;
        }
        .table tr:nth-child(even) {background-color: #f2f2f2;}
        .table tr:hover {background-color: #ddd;}
        .btn-icon {margin-right: 5px;}
        .form-control {width: 100%; padding: 5px; box-sizing: border-box;}
.icon-btn{
    display:inline-flex;align-items:center;justify-content:center;
    width:32px;height:32px;border-radius:4px;
    font-size:14px;margin-right:4px;cursor:pointer;
}
.icon-success{background:#28a745;color:#fff}
.icon-cancel{background:#6c757d;color:#fff}
.icon-btn:hover{opacity:.85}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
    <br />
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
   

    <div class="card card-info">
    <div class="card-header">
        <h3 class="card-title">Update/Delete Policy</h3>
    </div>
    <div class="card-body">
    <div>
        <div style="margin-bottom:10px; display: flex; align-items: center; gap: 5px;">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" />
            <asp:LinkButton 
    ID="btnSearch"
    runat="server"
    CssClass="btn btn-primary"
    OnClick="btnSearch_Click">
    <i class="fa fa-search"></i>
</asp:LinkButton>
            <asp:LinkButton 
    ID="btnClearSearch"
    runat="server"
    CssClass="btn btn-secondary"
    OnClick="btnClearSearch_Click">
    <i class="fa fa-times"></i>
</asp:LinkButton>
        </div>

        <asp:GridView ID="gvPolicies" runat="server" AutoGenerateColumns="False"
             DataKeyNames="PolicyID,CompanyID,CategoryID"
            OnRowEditing="gvPolicies_RowEditing"
            OnRowCancelingEdit="gvPolicies_RowCancelingEdit"
              CssClass="table table-bordered table-striped"
            OnRowUpdating="gvPolicies_RowUpdating"
            OnRowDeleting="gvPolicies_RowDeleting"
            OnRowDataBound="gvPolicies_RowDataBound"
            AllowPaging="True" PageSize="5"
            OnPageIndexChanging="gvPolicies_PageIndexChanging">

            <Columns>
                <asp:TemplateField HeaderText="S.No">
                    <ItemTemplate>
                        <%# ((GridViewRow)Container).RowIndex + 1 + (gvPolicies.PageIndex * gvPolicies.PageSize) %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="PolicyID" HeaderText="Policy ID" ReadOnly="true" Visible="false" />

                <asp:TemplateField HeaderText="Customer Name">
                    <ItemTemplate><%# Eval("Name") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Owner">
                    <ItemTemplate><%# Eval("OwnerName") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOwnerName" runat="server" Text='<%# Bind("OwnerName") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Address">
                    <ItemTemplate><%# Eval("Address") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Vehicle No">
                    <ItemTemplate><%# Eval("VehicleNo") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtVehicleNo" runat="server" Text='<%# Bind("VehicleNo") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Particular">
                    <ItemTemplate><%# Eval("Particular") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtParticular" runat="server" Text='<%# Bind("Particular") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Sum Insured">
                    <ItemTemplate><%# Eval("SumInsured") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtSumInsured" runat="server" Text='<%# Bind("SumInsured") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Premium">
                    <ItemTemplate><%# Eval("Premium") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPremium" runat="server" Text='<%# Bind("Premium") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="NCB">
                    <ItemTemplate><%# Eval("NCB") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtNCB" runat="server" Text='<%# Bind("NCB") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Policy No">
                    <ItemTemplate><%# Eval("PolicyNo") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPolicyNo" runat="server" Text='<%# Bind("PolicyNo") %>' CssClass="form-control"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Start Date">
                    <ItemTemplate><%# Eval("InsuredDate", "{0:dd/MM/yyyy}") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtStartDate" runat="server" 
                            Text='<%# Bind("InsuredDate","{0:yyyy-MM-dd}") %>' 
                            CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="End Date">
                    <ItemTemplate><%# Eval("ExpireDate","{0:dd/MM/yyyy}") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEndDate" runat="server" 
                            Text='<%# Bind("ExpireDate","{0:yyyy-MM-dd}") %>' 
                            CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                
                <asp:BoundField DataField="CompanyID" HeaderText="CompanyID" Visible="false"/>
                <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" Visible="false" />

                <asp:TemplateField HeaderText="Company">
                    <ItemTemplate><%# Eval("CompanyName") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control"></asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Category">
                    <ItemTemplate><%# Eval("CategoryName") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>                
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>

                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" OnClientClick="ShowLoading();"  CssClass="btn btn-sm btn-warning">
                             <i class="fa fa-pen"></i>  
                            </asp:LinkButton>
                        &nbsp;
                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"
                            CommandArgument="<%# Container.DataItemIndex %>" 
                            OnClientClick="return confirm('Are you sure you want to delete this record?');"
                            CssClass="btn btn-sm btn-danger" >
                            <i class="fa fa-trash"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" OnClientClick="ShowLoading();" CssClass="icon-btn icon-success">
                              <i class="fa fa-check"></i>
                            </asp:LinkButton>
                        &nbsp;
                        <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" OnClientClick="ShowLoading();" CssClass="icon-btn icon-cancel">
                              <i class="fa fa-times"></i>
                            </asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
        </div>
        </div>
</asp:Content>
