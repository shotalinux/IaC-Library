# Terraform Naming Module

This module generates **consistent, customizable resource names** for multi-cloud environments. It supports **prefix + suffix patterns**, explicit name lists, and advanced options like **case transformation**, **slugify**, and **max length enforcement**.

---

## ✅ Features

- Prefix + suffix generation
- Suffix styles:
  - **numeric** (with zero padding)
  - **alpha** (supports AA..ZZ up to 676 replicas)
- Separator control
- Case transform: `upper`, `lower`, or `none`
- Deduplication of names
- Slugify (removes invalid characters: @#*!$ etc., keeps only alphanumeric, hyphens, underscores)
- Max length enforcement (default: 63)
- Explicit names list support
- Provider-agnostic (no cloud dependencies)

---

## 🔄 Processing Order

Names are processed in this sequence:

1. **Combine** prefix+suffix and nameslist
2. **Slugify** (remove invalid chars, convert to lowercase)
3. **Case transform** (upper/lower/none applied after slugify)
4. **Max length** enforcement
5. **Deduplication** (if enabled)

---

## 📦 Inputs

| Name           | Description                                      | Type          | Default      |
|---------------|--------------------------------------------------|--------------|-------------|
| `namepref`    | Prefix for names when replicas are used          | `string`     | `""`        |
| `environment_string` | Environment string to include (e.g., dev) | `string`     | `""`        |
| `custom_string` | Custom string to include                       | `string`     | `""`        |
| `replicas`    | Number of replicas when using prefix             | `number`     | `0`         |
| `nameslist`   | Explicit list of names                           | `list(string)`| `[]`        |
| `suffix_style`| Suffix style: `numeric` or `alpha`              | `string`     | `numeric`   |
| `zero_padding`| Digits for numeric suffix (e.g., `2` → `01`)    | `number`     | `2`         |
| `start_index` | Starting index for numeric suffix               | `number`     | `1`         |
| `separator`   | Separator between prefix and suffix             | `string`     | `-`         |
| `case`        | Case transform: `upper`, `lower`, or `none`     | `string`     | `none`      |
| `distinct`    | Deduplicate names                                | `bool`       | `true`      |
| `max_length`  | Max length after slugify                        | `number`     | `63`        |

---

## 🔍 Outputs

- `names` → Final list of generated names.

---

## ⚠️ Validation Rules

- At least one naming method must be provided (name components + replicas OR nameslist).
- Alpha suffix supports up to 26×26 = 676 replicas (AA..ZZ).
- Slugify removes invalid characters and converts to lowercase before case transformation is applied.
- Max length is enforced after all transformations.

---

## ✅ Examples

### **1. Numeric suffix with padding**
```hcl
module "names" {
  source       = "../naming_module"
  namepref     = "web"
  replicas     = 3
  suffix_style = "numeric"
  zero_padding = 2
  separator    = "-"
  case         = "lower"
}
```

**Output:** `["web-01","web-02","web-03"]`

---

### **2. Environment and Custom String**
```hcl
module "names" {
  source             = "../naming_module"
  namepref           = "app"
  environment_string = "dev"
  custom_string      = "v1"
  replicas           = 2
  separator          = "-"
}
```

**Output:** `["app-dev-v1-01","app-dev-v1-02"]`

---

### **3. Alpha suffix (AA..ZZ)**
```hcl
module "names" {
  source       = "../naming_module"
  namepref     = "node"
  replicas     = 5
  suffix_style = "alpha"
  separator    = "_"
  case         = "upper"
}
```

**Output:** `["NODE_AA","NODE_AB","NODE_AC","NODE_AD","NODE_AE"]`

---

### **3. Explicit names list**
```hcl
module "names" {
  source     = "../naming_module"
  nameslist  = ["api", "worker", "queue"]
}
```

**Output:** `["api","worker","queue"]`

---

### **4. Mixed mode (prefix + explicit list)**
```hcl
module "names" {
  source       = "../naming_module"
  namepref     = "app"
  replicas     = 2
  nameslist    = ["db","cache"]
  suffix_style = "numeric"
}
```

**Output:** `["app-01","app-02","db","cache"]`

---

### **5. Enforce max length and slugify**
```hcl
module "names" {
  source       = "../naming_module"
  nameslist    = ["My@Invalid#Name!", "Another*Name"]
  max_length   = 10
}
```

**Output:** `["myinvalidn","anothernam"]`

*(Slugify removes special chars, converts to lowercase, then truncates)*

---

### **6. Deduplication**
```hcl
module "names" {
  source       = "../naming_module"
  nameslist    = ["api","api","worker"]
  distinct     = true
}
```

**Output:** `["api","worker"]`

---

## 📝 Notes

- Slugify is always applied to ensure cloud provider compatibility
- Case transformation happens **after** slugify (so `case = "upper"` will uppercase the slugified result)
- Alpha suffixes start at AA, AB, AC... (not A, B, C) for consistency with multi-character patterns

---

## 🔧 Requirements

- Terraform >= 1.3.0

---

## 📄 License

MIT