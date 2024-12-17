# generate pypi_packages mapping for terraform from requirements.txt


def generate_pypi_packages():
    requirements_file = "requirements.txt"
    pypi_packages = {}

    with open(requirements_file, "r") as file:
        for line in file:
            line = line.strip()
            if not line or line.startswith("#"):
                continue

            if "==" in line:
                package, version = line.split("==")
                pypi_packages[package] = f'"=={version}"'

            elif ">=" in line:
                package, version = line.split(">=")
                pypi_packages[package] = f'">={version}"'

            elif "[" in line and "]" in line:
                if ">=" in line:
                    package, extra_version = line.split(">=")
                    package, extra = package.split("[")
                    extra = extra.replace("]", "")
                    pypi_packages[f"{package}"] = f'"[{extra}]>={extra_version}"'
                else:
                    package, extra = line.split("[")
                    extra = extra.replace("]", "")
                    pypi_packages[f"{package}"] = f'"[{extra}]"'

            else:
                pypi_packages[line] = '""'

    return pypi_packages


if __name__ == "__main__":
    pypi_packages = generate_pypi_packages()
    print("PYPI_PACKAGES = {")
    for package, version in pypi_packages.items():
        print(f"    {package} = {version}")
    print("}")
