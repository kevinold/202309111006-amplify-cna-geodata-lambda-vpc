import {
  Heading,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  View,
} from "@aws-amplify/ui-react";
import { useEffect, useState } from "react";

type Country = {
  name: string;
  states: string[];
};

export default function Home() {
  const [geoData, setGeoData] = useState<Country[]>([]);

  async function fetchGeoData() {
    const response = await fetch("/api/getGeoData")
      .then((res) => res.json())
      .then((data) => {
        const payload = JSON.parse(data.data.Payload);
        const body = JSON.parse(payload.body);
        setGeoData(body);
      });
  }

  useEffect(() => {
    fetchGeoData();
  }, []);
  return (
    <View padding="1rem">
      <Heading level={2} marginBottom={25}>
        Countries and States
      </Heading>
      <br />

      {geoData.length === 0 && <div>Loading...</div>}
      {geoData.length > 0 && (
        <Table width={500}>
          <TableHead>
            <TableRow>
              <TableCell as="th">Country</TableCell>
              <TableCell as="th">States</TableCell>
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
      )}
    </View>
  );
}
