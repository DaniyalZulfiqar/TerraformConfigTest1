
    // Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.
    // Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
    
    variable "compartment_ocid" {}
    variable "tenancy_ocid" {}
    variable "region" {}

    provider "oci" {
      tenancy_ocid     = var.tenancy_ocid
      region           = var.region
    }
    variable "team_info" {}
    variable "regionMap" {}
    variable "numberMap" {}
    variable "booleanMap" {}
    variable "arrayMap" {}
    variable "enumMap" {}
    variable "newMap" {}
