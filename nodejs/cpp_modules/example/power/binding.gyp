{
  "targets": [
    {
      "target_name": "power",
      "sources": ["./src/power.cc"],
      "include_dirs": [
        "<!(node -e \"require('nan')\")"
      ]
    }
  ]
}