import unittest
import importlib.resources
import yaml
from felis.datamodel import Schema


class SchemaResourceTestCase(unittest.TestCase):
    """Test reading of schema data from a resource."""

    def test_read_resource(self) -> None:
        """Test that schema data can be read from a resource."""
        resource = importlib.resources.files("lsst.sdm_schemas.schemas").joinpath(
            "dp02_dc2.yaml"
        )
        raw_data = resource.read_text()
        data = yaml.safe_load(raw_data)
        Schema.model_validate(data)


if __name__ == "__main__":
    unittest.main()
