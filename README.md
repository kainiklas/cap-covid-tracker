# Yet another covid-19 tracker using CAP + Fiori Elements

This is a sample project to evaluate and explore some capabilities of SAP CAP and Fiori Elements.

The goal was to better understand and learn how to:

- Call a **remote service** with standard SAP CAP capabilities
- Explore options to map **REST to OData Services**
- Visualize Data with **Fiori Elements**

## Screenshots

![List Report](media/list-report.png)
![Object Page](media/object-page.png)

## Project Structure

| File or Folder | Purpose                             |
| -------------- | ----------------------------------- |
| `app/`         | content for UI frontends (not used) |
| `db/`          | domain models and mock data         |
| `srv/`         | service models                      |
| `srv/external` | call and mapping of remote service  |
| `package.json` | project metadata and configuration  |
| `.cdsrc.json`  | config file for CAP                 |

## Steps for development

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Open <http://localhost:4004>

## Learn More about SAP CAP

Learn more at <https://cap.cloud.sap/docs/get-started/>.
