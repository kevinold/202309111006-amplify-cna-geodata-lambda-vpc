import {
  Heading,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
} from "@aws-amplify/ui-react";
import { API } from "aws-amplify";
import { useEffect, useState } from "react";

export default function Home() {
  const [geoData, setGeoData] = useState([]);

  async function fetchGeoData() {
    const response = await API.get("geoDataApi", "/api/getGeoData", {});
    setGeoData(response);
  }

  useEffect(() => {
    fetchGeoData();
  }, []);
  return (
    <div>
      <Heading level={3}>Countries and States</Heading>

      <Table>
        <TableHead>
          <TableRow>
            <TableCell as="header">Country</TableCell>
            <TableCell as="header">States</TableCell>
          </TableRow>
        </TableHead>

        <TableBody>
          {geoData.map((country) => (
            <TableRow key={country.name}>
              <TableCell>{country.name}</TableCell>
              <TableCell>
                {country.states.map((state) => (
                  <div key={state}>{state}</div>
                ))}
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}
