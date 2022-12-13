# Landing Zone Laboratory

This module will crate a landing zone to be used as a personal laboratory.

### Required Fields

- **name**: Laboratory name 

### Optional Fields
- **location**: string | Azure Zone - Default: West Europe
- **default_tags**: map[string:string] | Resources tags
- **service_accont_level**: object | Storage account configuration 

**service_account_level**:
- **replication_type** - Default: LRS
- **tier**:string | Default: Standard

### Output values
- container_state_name - Container Name 
- resource_group_name - Resource Group Name
- resource_group_id - Resource Group ID
- resources_base_location - Resources Location