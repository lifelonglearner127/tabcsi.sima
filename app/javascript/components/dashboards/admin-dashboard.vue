<script>
// import {} from 'mdbvue'

export default {
  name: 'AdminDashboard',

  components: {},

  props: {
    user: {
      type: Object,
      required: true
    }
  }
}
</script>

<template>
  <b-tabs>
    <b-tab active>
      <template slot="title">
        <fa-sprite use="fas-fa-user"></fa-sprite>
        Users
      </template>
      <h1>Users</h1>
    </b-tab>
    <b-tab>
      <template slot="title">
        <fa-sprite use="fas-fa-map-marker-alt"></fa-sprite>
        Locations
      </template>
      <h1>Locations</h1>
    </b-tab>
  </b-tabs>
  <!--<b-row>
    <b-col sm>
      <b-nav
        class="indig"
        tabs
      >
        <b-nav-item>
          <a
            class="nav-link active"
            data-toggle="tab"
            href="#users"
            role="tab"
          >
            <i class="fa fa-user" /> Users
          </a>
        </b-nav-item>
        <b-nav-item>
          <a
            class="nav-link"
            data-toggle="tab"
            href="#Locations"
            role="tab"
          >
            <i class="fa fa-map-marker-alt" /> Locations
          </a>
        </b-nav-item>
      </b-nav>
    </b-col>
  </b-row>-->

  <!--<div class="tab-content border">
    <div
      id="users"
      class="tab-pane fade in show active"
      role="tabpanel"
    >
      <ul class="mt-4 mb-1 action nav">
        <li>
          <a
            class="edit"
            href="#"
          >
            <i class="fa fa-user-edit" /> Edit
          </a>
        </li>
        <li>
          <a href="#"><i class="fa fa-user-times" /> Delete</a>
        </li>
        <li class="user-invite">
          <a href="#"><i class="fa fa-plus" /> Invite User</a>
          <ul
            class="ht-dropdown ht-account invite-user-option"
            style="padding-top: 10px;"
          >
            <li>
              <a href="#"><i class="fa fa-plus" /> Manual Add</a>
            </li>
            <li>
              <a href="#"><i class="fa fa-file-upload" /> Upload CSV</a>
            </li>
          </ul>
        </li>
      </ul>

      <div class="table-responsive">
        <table
          id="users-table"
          cellspacing="0"
          class="table table-hover border"
          width="100%"
        >
          <thead>
            <tr>
              <th
                class="th-sm"
                style="width: 50px;"
              >
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      id="select-all"
                      class="material-control-input"
                      name="select-all"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </th>
              <th
                class="th-sm"
                style="width: 250px;"
              >
                E-mail address
              </th>
              <th
                class="th-sm"
                style="width: 100px;"
              >
                User Type
              </th>
              <th class="th-sm">
                Locations
              </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                admin@gmail.com
              </td>
              <td>
                Admin
              </td>
              <td>
                <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                user@gmail.com
              </td>
              <td>
                user
              </td>
              <td>
                <span class="Locations-column">
                  <ul class="nav row">
                    <li class="col-md-12 p-md-0">
                      <span class="col-md-10">ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                      <a
                        class="text-info view col-md-2"
                        href="#"
                      >
                        View All Locations <i class="fa fa-chevron-down" />
                      </a>
                    </li>
                    <li class="col-md-12 ">
                      <ul class="nav all-Locations row">
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                Admin@gmail.com
              </td>
              <td>
                Admin
              </td>
              <td>
                <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                user@gmail.com
              </td>
              <td>
                user
              </td>
              <td>
                <span class="Locations-column">
                  <ul class="nav row">
                    <li class="col-md-12 p-md-0">
                      <span class="col-md-10">ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                      <a
                        class="text-info view col-md-2"
                        href="#"
                      >
                        View All Locations <i class="fa fa-chevron-down" />
                      </a>
                    </li>
                    <li class="col-md-12">
                      <ul class="nav all-Locations row">
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                user@gmail.com
              </td>
              <td>
                user
              </td>
              <td>
                <span class="Locations-column">
                  <ul class="nav row">
                    <li class="col-md-12 p-md-0">
                      <span class="col-md-10">ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                      <a
                        class="text-info view col-md-2"
                        href="#"
                      >
                        View All Locations <i class="fa fa-chevron-down" />
                      </a>
                    </li>
                    <li class="col-md-12">
                      <ul class="nav all-Locations row">
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                user@gmail.com
              </td>
              <td>
                user
              </td>
              <td>
                <span class="Locations-column">
                  <ul class="nav row">
                    <li class="col-md-12 p-md-0">
                      <span class="col-md-10">ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                      <a
                        class="text-info view col-md-2"
                        href="#"
                      >
                        View All Locations <i class="fa fa-chevron-down" />
                      </a>
                    </li>
                    <li class="col-md-12">
                      <ul class="nav all-Locations row">
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                buser@gmail.com
              </td>
              <td>
                user
              </td>
              <td>
                <span class="Locations-column">
                  <ul class="nav row">
                    <li class="col-md-12 p-md-0">
                      <span class="col-md-10">ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                      <a
                        class="text-info view col-md-2"
                        href="#"
                      >
                        View All Locations <i class="fa fa-chevron-down" />
                      </a>
                    </li>
                    <li class="col-md-12">
                      <ul class="nav all-Locations row">
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                user@gmail.com
              </td>
              <td>
                user
              </td>
              <td>
                <span class="Locations-column">
                  <ul class="nav row">
                    <li class="col-md-12 p-md-0">
                      <span class="col-md-10">ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                      <a
                        class="text-info view col-md-2"
                        href="#"
                      >
                        View All Locations <i class="fa fa-chevron-down" />
                      </a>
                    </li>
                    <li class="col-md-12">
                      <ul class="nav all-Locations row">
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                user@gmail.com
              </td>
              <td>
                user
              </td>
              <td>
                <span class="Locations-column">
                  <ul class="nav row">
                    <li class="col-md-12 p-md-0">
                      <span class="col-md-10">ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                      <a
                        class="text-info view col-md-2"
                        href="#"
                      >
                        View All Locations <i class="fa fa-chevron-down" />
                      </a>
                    </li>
                    <li class="col-md-12">
                      <ul class="nav all-Locations row">
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </span>
              </td>
            </tr>
            <tr>
              <td>
                <div class="custom-controls-stacked">
                  <label class="custom-control material-checkbox">
                    <input
                      class="material-control-input"
                      type="checkbox"
                    >
                    <span class="material-control-indicator" />
                  </label>
                </div>
              </td>
              <td>
                user@gmail.com
              </td>
              <td>
                user
              </td>
              <td>
                <span class="Locations-column">
                  <ul class="nav row">
                    <li class="col-md-12 p-md-0">
                      <span class="col-md-10">ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                      <a
                        class="text-info view col-md-2"
                        href="#"
                      >
                        View All Locations <i class="fa fa-chevron-down" />
                      </a>
                    </li>
                    <li class="col-md-12 ">
                      <ul class="nav all-Locations  row">
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                        <li class="col-md-12">
                          <span>ExxonMobil House, Ermyn Way, Leatherhead KT22 8UX, UK</span>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div
      id="Locations"
      class="tab-pane fade"
      role="tabpanel"
    >
      <div class="row" />
    </div>
  </div>-->
</template>

<style lang="scss" scoped>
</style>
